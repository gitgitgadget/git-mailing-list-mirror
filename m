From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 4/8] git-repack --max-pack-size: add fixup_header_footer()
Date: Mon, 9 Apr 2007 12:11:26 -0700
Message-ID: <56b7f5510704091211i3d101cafq371fbb96ca27238b@mail.gmail.com>
References: <46197950.3080804@gmail.com>
	 <7vwt0m76rv.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.98.0704082012220.28181@xanadu.home>
	 <20070409173858.GT5436@spearce.org>
	 <alpine.LFD.0.98.0704091404530.28181@xanadu.home>
	 <20070409184039.GZ5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:53:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HazH2-0003F9-9d
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbXDITL2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbXDITL2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:11:28 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:37133 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbXDITL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:11:27 -0400
Received: by wr-out-0506.google.com with SMTP id 71so957897wri
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 12:11:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r7lKxElDuGDQj7TdwpV/4iMPfRDjzXzU5FsWHGPUB4ZN/BXb+axjgqzSUemc9R0Sbwy14C1E1QdiUSkY+tYYv0QFkDr4mA2J5ifgATaJ1G7GgUlSjFJXTrCn9lwi3I32L9yz8Jp5HBdbUf+7PUeddvr9Fw2mTCil6zeQpb2/lIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mYqhJSNiNqt7HPr1euvJIxmZCwkUSykT+eVVqZhUGSZho4FtLB/e5jBKnoqbMRpxbXEra+L5qunMeQA8r2qohHlj814A6svbqRc5wLUcRWrPxTs1tt+OnPH8duci9B4wbpeZ0dYCZFmru/vX3Tcd3n8XA066hu08rBx2d+ldQFI=
Received: by 10.114.110.1 with SMTP id i1mr2466865wac.1176145886515;
        Mon, 09 Apr 2007 12:11:26 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Mon, 9 Apr 2007 12:11:26 -0700 (PDT)
In-Reply-To: <20070409184039.GZ5436@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44085>

On 4/9/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > I'd be really tempted to create a pack v4 which only change is to still
> > have the pack header at the beginning of the pack like we do today, but
> > include the header in the pack SHA1 computation at the end of the stream
> > only.  This way the pack SHA1 could be computed as the pack is
> > generated, and the header fixed up without having to read the entire
> > pack back.  I think it was Geert Bosch who proposed this and it makes
> > tons of sense IMHO.
>
> Yes.  If we really are heading in this direction of needing to
> correct object counts, we should make that change.  Its trivial
> to hang onto that header for the duration of the rest of the data
> processing, and tack it onto the end for final SHA-1 computation.

I like the property that when an SHA-1 appears at the end of a file,
it is a checksum of every byte before it.  The ideas above are a
departure from that.  Do we want this rule to be different for each file type?

Wouldn't the following address the "object count unknown
at the start of sequential pack writing" problem:
  Write 0 for object count in the header. This is a flag to look for
  another header of same format just before the final SHA-1 which
  has the correct count. The SHA-1 is still a checksum of everything
  before it and no seeking/rewriting is needed on generation.  When
  reading the object count from a .pack file, you might need to add
      xread(pack_fd, &header, sizeof(header));
+    if (!header.object_count) {
+      lseek(pack_fd, -20-sizeof(header), SEEK_END);
+      xread(pack_fd, &header, sizeof(header);
+    }
  Or maybe you want this before the object_list_sha1 instead (20->40).

Finally, when I generate several 2GB split packfiles,  I do notice
the slight delay for fixup_header_footer(), and I do think it's a bit
ugly, but in quantitative terms it's an insignificant part of a long
operation that's infrequently performed.  Does this need to be
optimized at all?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
