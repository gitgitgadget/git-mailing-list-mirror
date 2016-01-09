From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Should notes handle replace commits?
Date: Sat, 9 Jan 2016 17:39:13 -0000
Organization: OPDS
Message-ID: <181337AE5CFC4AF09B82187B8E97095D@PhilipOakley>
References: <20160108012830.GA2110@glandium.org><xmqqh9in25py.fsf@gitster.mtv.corp.google.com><20160108214939.GA22801@glandium.org><xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com><20160109002510.GA30050@glandium.org> <xmqqmvsfzhq4.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 18:39:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHxUD-00017o-Qe
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 18:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690AbcAIRj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 12:39:29 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:22937 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754682AbcAIRjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jan 2016 12:39:16 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CQHQDXRJFWPO+cLFBVCRkBAQEBCwECAQEBAQGDClJth02BDLU8BxgKhWcBAwEBgRhNAQEBAQEBBwEBAQFBJBuELwUBAQEBAgEIAQEuFggBASEFBgIDBQIBAxUBCyUUAQQYAgYHAxQGAQcLCAIBAgMBDASFdYIQDAq3C4kuDAEghlaEf4Qtg3SBGwWNeYkaAYE2hAyFXIQYFjSMVYpeg3OCdRyBXT40AYQVgUsBAQE
X-IPAS-Result: A2CQHQDXRJFWPO+cLFBVCRkBAQEBCwECAQEBAQGDClJth02BDLU8BxgKhWcBAwEBgRhNAQEBAQEBBwEBAQFBJBuELwUBAQEBAgEIAQEuFggBASEFBgIDBQIBAxUBCyUUAQQYAgYHAxQGAQcLCAIBAgMBDASFdYIQDAq3C4kuDAEghlaEf4Qtg3SBGwWNeYkaAYE2hAyFXIQYFjSMVYpeg3OCdRyBXT40AYQVgUsBAQE
X-IronPort-AV: E=Sophos;i="5.20,545,1444690800"; 
   d="scan'208";a="825468367"
Received: from 80-44-156-239.dynamic.dsl.as9105.com (HELO PhilipOakley) ([80.44.156.239])
  by out1.ip01ir2.opaltelecom.net with SMTP; 09 Jan 2016 17:39:13 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283605>


From: "Junio C Hamano" <gitster@pobox.com>
Sent: Saturday, January 09, 2016 1:04 AM
> Mike Hommey <mh@glandium.org> writes:
>
>> So while `cat-file commit A` gives you what `cat-file commit Z` would,
>> `notes show A` doesn't give you what `notes show Z` would. And that's
>> this "inconsistency" that bothers me.
>
> In any case, 'notes' being a way to add extra information to an
> existing object means that with your original "replace" that tells
> Git to keep A in the history (and give Z's contents when contents of
> A was asked),
>     it is absolutely correct that notes for A is shown.

This seems very wrong to me. Surely we have asked that _all_ references to A 
be replaced by a reference to Z and thence onward to Z's contents.

That is, unless 'git --no-replace-objects' was given as an option.

It is as if everything about the old 'A' has been deleted, and new content 
'Z' replaces it.

In this case surely we want the notes about the contents of the new Z. To 
mix up the old and new will cause confusion, as evidenced by Mike's post.

> It would make no sense if notes for Z "followed", because as long as
> Git is concerned, you told Git to show A when your "git log master"
> followed the history down thru B to its parent, which you did not
> rewrite to be Z but kept to be A.  With the approach to replace B
> with B' that has Z as its parent, when "git log master" follows the
> history down thru C to its parent, Git thinks it is showing B but
> reads B', and finds out its parent is Z and goes down to Z, and
> notes for these two commits B and Z (not B' and Z) would be shown;
> there is no need to "follow".
>
> The true source of your confusion, I think, is that there is a
> misunderstanding of what "replace A with Z" does.
>
> It is not "whenever somebody refers to A, pretend as if it is
> referring to Z".  If that _were_ the case, then I'd agree that
> "whenever somebody else asks notes attached to A, pretend as if
> notes attached to Z were asked" might make sense, but that does not
> match the reality.

I think Mike is pointing out that it is only for notes that this alternate 
reality unexpectedly happens.

>
> It is not graft vs replace.  It is about what you replace with what
> other thing: "replace" is a content replacement mechanism, not
> identity replacement mechanism.

Part of the graft vs replace difficulty (historically) was that a graft 
(easy to use) will keep all the commits, and add a traversal link, while 
replace would essentially 'delete' one of the commits (users did not have a 
spare commit to delete if linking histories). The newer --graft option is 
now the appropriate method of creating an extra commit (that has the extra 
traverse linkage) that can then be 'deleted' and replaced by the commit on 
the other traverse chain.

There is the case where we have a string of commits (A-B-C-D-E) and we 
simply want to swap out commit C and replace it with a new commit C' to 
create (A-B-C'-D-E). A new C' would be prepared, and then upon replacement 
of C by C' we have to ask "What should be done about the old notes that were 
attached to C?".

I think that it maybe here that the issue lies. Some will think that the 
notes of the old C should still be attached to that location in the string, 
while others may think that it's for the user to both notice, and check the 
veracity, and only then carry those old notes across to the new C' 
(manually).

--
Philip

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
