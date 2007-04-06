From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 09/13] drop objects larger than --blob-limit if specified
Date: Thu, 5 Apr 2007 19:19:39 -0700
Message-ID: <56b7f5510704051919v7daac590m6ac52c4fcabd5321@mail.gmail.com>
References: <56b7f5510704051536s7de9638fs8cd811d580f6a7dc@mail.gmail.com>
	 <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 04:22:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZe3I-0006kq-A5
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 04:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767502AbXDFCTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 22:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767503AbXDFCTm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 22:19:42 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:22811 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767502AbXDFCTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 22:19:41 -0400
Received: by wx-out-0506.google.com with SMTP id h31so798509wxd
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 19:19:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rW+CcyUhdoIYHFrcEFFRByqs8NseYkqeXApwGrCDbFgnZnPl9qvl+hf9ZAVyKQTAaNhIJxC+o2PlD1Sw89AUKmC7guRqSpO74tMJW0Mm+qsmOvBIXu0hy6FkrIao9ifMjcNRcdFFb0bGJoETu2PuB2LV3jilI/O5ULXXaK2Frcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Dh4RB6lZfgmqEFYy7yxcHbVWbxNpi2L8rMVCR7vVtXEi6dz5q67AKFzEgU7H+8lIgYBh1ohygxbaqnMDmMpTkXLiydWnQS48c8bpdbU1ZZWIIhNTRUeRJcuBPaOdruhbCApPYmyGy46LjFb5nv0Onx7yZiw7f43xYNKf1PtbySY=
Received: by 10.114.197.1 with SMTP id u1mr1036162waf.1175825979828;
        Thu, 05 Apr 2007 19:19:39 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 19:19:39 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704052103410.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43894>

On 4/5/07, Nicolas Pitre <nico@cam.org> wrote:
> I still consider this feature to make no sense.

Well, suppose I'm packing my 55GB of data into 2GB
packfiles.  There seemed to be some agreement that
limiting packfile size was useful.  700MB is another example.

Now,  suppose there is an object whose packing would
result in a packfile larger than the limit.  What should we do?

(1) Refuse to run.  This solution means I can't pack my repository.
(2) Pack the object any way and let the packfile size exceed
     my specification.  Ignoring a clear preference from the user
     doesn't seem good.
(3) Pack the object by itself in its own pack. This is better than the
     previous since I haven't wrapped up any small object in a pack
     whose size I dont't want to deal with.  The resulting pack is too big,
     but the original object was also too big so at least I haven't made
     the problem worse.  But why bother wrapping the object so?
     I just made the list of packs to look through longer for every access,
     instead of leaving the big object in the objects/xx directories which
     are already used to handle exceptions (usually meaning more recent).
     In my 55GB example, I have 9 jumbo objects, and this solution
     would more than double the number of packs to step through.
     Having them randomly placed in 256 subdirectories seems better.
(4) Just leave the jumbo object by itself, unpacked.

What do you think?

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
