From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: [PATCH 1/2] mailinfo: support rfc3676 (format=flowed) text/plain messages
Date: Sat, 16 Feb 2008 14:34:44 +0000
Message-ID: <20080216143444.GU2456@cisco.com>
References: <1203042077-11385-1-git-send-email-jaysoffian@gmail.com> <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 15:46:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQOIy-00073R-DH
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 15:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbYBPOpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 09:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbYBPOpY
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 09:45:24 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22229 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbYBPOpW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 09:45:22 -0500
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Feb 2008 09:45:22 EST
Received: from ams-dkim-2.cisco.com ([144.254.224.139])
  by ams-iport-1.cisco.com with ESMTP; 16 Feb 2008 15:35:02 +0100
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m1GEZ2ZH015750;
	Sat, 16 Feb 2008 15:35:02 +0100
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id m1GEYtp6000687;
	Sat, 16 Feb 2008 14:35:00 GMT
Received: from dfawcus-laptop (localhost [127.0.0.1]) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) with ESMTP id m1GEYtX20126; Sat, 16 Feb 2008 14:34:55 GMT
Content-Disposition: inline
In-Reply-To: <7vr6fei1s4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.3i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=2127; t=1203172502; x=1204036502;
	c=relaxed/simple; s=amsdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20[PATCH=201/2]=20mailinfo=3A=20support=2
	0rfc3676=20(format=3Dflowed)=20text/plain=20messages
	|Sender:=20;
	bh=7rhp4H9NuBtVhVGNZ0K/sVPnIN5WoUnfgdBS2z/P+jU=;
	b=rwD6Nl8zU+Iclr7LpE322yCM++tO2n6UVsZ4rUN75ONIo9Axh5XyaNR9fp
	SQDjTURTICmq7EX8PnhA/l9+FkQE9VsFx24W3X1KzHzuU++ujaTAAfUcc2TW
	XQ4ORcCOBW;
Authentication-Results: ams-dkim-2; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim2001 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74045>

On Fri, Feb 15, 2008 at 09:10:19AM -0800, Junio C Hamano wrote:
> I really do not like this.
> 
> format=flowed instructs the receivers MUA that it is Ok to
> reflow the text when the message is presented to the user.  That
> is exactly what we do _NOT_ want to happen to patches.  Your
> implementation may cleanly salvage what the sender intended to
> send, but salvaging when applying the patch is too late.
> 
> You review the patch, decide to apply or reject, and then
> finally apply.  Unmangling of corrupt contents should be done
> before you review, not before you apply.

I have to agree that this is a bad idea - for the reasons stated,
and one additional:

There are MUA's which send 'format=fixed' email marked as 'format=flowed'.

At which point the receiving MUA performing the deflowing _will_ get
a corrupt patch.

I saw this recently wrt to internal company code reviews.  We have
a variety of different MUAs in use on a variety of different OSs.

Some 'properly' implement format=flowed,  some do not.   Some always
send format=flowed for text,  some can have it disabled to send
format=fixed.  Despite what the RFCs say,  some of them also QP
or base64 encode such flowed pieces of text.  It is a nightmare.

However it seems thay all use fixed format for attachments,  unfortunately
some them always tag those as application/octet-stream,  so one cannot
automatically process them (in the absense of other clues).

I am able to work around some of these issues by configuing mutt to
do some guesses when it sees application/x-patch,  or application/octet-stream
and a file with say as '.diff' extension.

But ultimately for some of these one is forced to contact the original
author and get access to the actual patch file on the filesystem.
While this can be done for a 'small' community,  it is not something
that would work in the wider world.

So - format=flowed is simply unsuitable for fixed format text and should
not be used.

[Actually it rather turns out format=flowed is a bad idea all together,
 you should see what it does to log files...]

DF
