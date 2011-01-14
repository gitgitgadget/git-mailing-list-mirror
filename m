From: Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Re: Applying .gitattributes text/eol changes
Date: Fri, 14 Jan 2011 10:05:52 +0100
Message-ID: <4D3011F0.5040900@syntevo.com>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com> <4D2EFCBD.4020402@drmicha.warpmail.net> <4D2F0BF3.2000808@syntevo.com> <4D2F0E3A.8090108@drmicha.warpmail.net> <4D2F12EE.4020400@syntevo.com> <7vd3o01iw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 10:06:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdfbm-0003Od-RV
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 10:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461Ab1ANJGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 04:06:05 -0500
Received: from syntevo.com ([85.214.39.145]:52500 "EHLO syntevo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab1ANJF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 04:05:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1]) with ESMTPSA id 5CC2E174006
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vd3o01iw9.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165083>

>> What do you think about "git checkout --fix-eols" option as an
>> alternative? Its uses cases are more limited, though.
> 
> What does it do?  "git checkout --fix-eols $path" will overwrite $path
> with the data at $path in the index?  Perhaps you can use the "-f" option.
> 
> Adding an option to "checkout" might be better than update-index from the
> UI point of view, but the issue is not just "eols".  "eol" is a mere
> special case of smudge filter that controls how the contents from the
> repository are modified before getting written out to the working tree.

So there could be a "--thoroughly" option which will skip the stat check
(checkout_entry) and instead perform the procedure already outlined for
rebase:

> 	open object
>         read from the object
>         deflate and write to a temporary file
>         open the existing file
>         read from the file and compare it to the temporary we just wrote
>         if same, delete, otherwise rename the temporary file.

AFAIU, this change will effect mainly checkout struct, checkout_entry
and write_entry. write_entry already deals with temporary files, so that
shouldn't be too complex!?

--
Best regards,
Marc Strapetz
=============
syntevo GmbH
http://www.syntevo.com
http://blog.syntevo.com




On 14.01.2011 00:30, Junio C Hamano wrote:
> Marc Strapetz <marc.strapetz@syntevo.com> writes:
> 
>> So your suggestion is to fix "git update-index --really-refresh", so
> 
> The option is about telling git: "Earlier I promised I wouldn't touch
> these paths by setting their assume-unchanged bit, but I touched them.
> Please refresh the cached stat information in the index, ignoring the
> promise I didn't keep."
> 
> I do not think it is a good idea to conflate your "Everything is suspect
> because smudge filter has changed; please recompute all" request into the
> same option.  People who use assume-unchanged would probably want "Please
> rescan because I changed smudge filter" request to be carried out while
> still honoring the assume-unchanged bit they set earlier.
> 
>> Anyway, I'm still wondering if it will resolve the "git reset --hard"
>> problem of re-checking out every file, even if content is already
>> identical in the working tree. I think that part has to be fixed, too.
> 
> There is not much to fix there. If you removed the index, then there is no
> information to tell you that "content is already identical" unless you
> actually check things out and compare.  By the time you found it out, you
> already have done the checkout.
> 
> IOW, the current code does:
> 
> 	open object
>         read from the object
>         deflate and write to the destination file
> 
> while your "fix" needs to look like this:
> 
> 	open object
>         read from the object
>         deflate and write to a temporary file
>         open the existing file
>         read from the file and compare it to the temporary we just wrote
>         if same, delete, otherwise rename the temporary file.
> 
> just for the rare case where there is an untracked file that the user is
> willing to overwrite (we are discussing "rm .git/index && reset --hard"
> here) happens to have the same contents.  Not a good enough reason to add
> unwelcome complexity to the codepath.
> 
>> What do you think about "git checkout --fix-eols" option as an
>> alternative? Its uses cases are more limited, though.
> 
> What does it do?  "git checkout --fix-eols $path" will overwrite $path
> with the data at $path in the index?  Perhaps you can use the "-f" option.
> 
> Adding an option to "checkout" might be better than update-index from the
> UI point of view, but the issue is not just "eols".  "eol" is a mere
> special case of smudge filter that controls how the contents from the
> repository are modified before getting written out to the working tree.
> 
> 
> 
> 
