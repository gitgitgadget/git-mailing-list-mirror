From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Mon, 12 Nov 2007 14:09:37 +0100
Message-ID: <1b46aba20711120509l104792ebo4ea9a51c710510f3@mail.gmail.com>
References: <473463E0.7000406@gmail.com>
	 <7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>,
	"Pierre Habouzit" <madcoder@debian.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 14:09:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrZ35-0008DM-U9
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 14:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbXKLNJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 08:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXKLNJk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 08:09:40 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:11839 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbXKLNJj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 08:09:39 -0500
Received: by nz-out-0506.google.com with SMTP id s18so944083nze
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 05:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=C18+a4R/GpoAzB8gwvNymYRv4ShoY9fp2KQCt+yVVJ0=;
        b=ScXWASdytPAlZhuZfrsgOjDKlyvXdAJmht08GXF/mbevT9jXoUuyakB3JZNR1nEFG771vXlvpfULi8duccEI61iPnc4T84rqdm5lHzdLkfF8DUkme3BIoOKScbarybBLUC+ndZD3WQjlyd8ra29/PI3FmI1r72zP/D5InhO/Tx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WFRtRaziQXGi1Xb6q5hm1Vs8jqfmFx0t50/kkUH5LrhNWU3iD3GocR93njRIytVjAbdm1CUoZD0HzdlEXMFpwpSqkTZU4t1K69t/CafLHhKlyhjiYqPCNKADXmDxzSFM5+MmaqhvY6wtHTLn8kqOj6SaIsNnEb8DzC+XLvfmynQ=
Received: by 10.142.245.10 with SMTP id s10mr970207wfh.1194872977797;
        Mon, 12 Nov 2007 05:09:37 -0800 (PST)
Received: by 10.142.88.7 with HTTP; Mon, 12 Nov 2007 05:09:37 -0800 (PST)
In-Reply-To: <7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64616>

2007/11/10, Junio C Hamano <gitster@pobox.com>:
> Carlos Rica <jasampler@gmail.com> writes:
>
> > Also, this removes those tests ensuring that repeated
> > -m options don't allocate memory more than once, because now
> > this is done after parsing options, using the last one
> > when more are given. The same for -F.
>
> The reason for this change is...?  Is this because it is
> cumbersome to detect and refuse multiple -m options using the
> parseopt API?  If so, the API may be what needs to be fixed.
> Taking the last one and discarding earlier ones feels to me an
> arbitrary choice.

You can do many things with repeated options.
Here in git-tag we considered two different ways to manage them:
Concatenating values for the option and/or refusing more than one.
I found that current option-parser can do both from the client
using callbacks, as Pierre shows me, so I think it is the right way to do it.

Pierre, by default, I think that the parser should print an error
when more than one option of the same type is given,
in order to report it to the command-line user,
but make this behaviour optional for the programmer.
Specifically, I thought in this last option:

enum parse_opt_option_flags {
	PARSE_OPT_OPTARG  = 1,
	PARSE_OPT_NOARG   = 2,
	PARSE_OPT_ALLOWREP = 4
};

> While I freely admit that I do not particularly find the "One -m
> introduces one new line, concatenated to form the final
> paragraph" handling of multiple -m options done by git-commit
> nice nor useful, I suspect that it would make more sense to make
> git-tag and git-commit handle multiple -m option consistently,
> if you are going to change the existing semantics.  Since some
> people really seem to like multiple -m handling of git-commit,
> the avenue of the least resistance for better consistency would
> be to accept and concatenate (with LF in between) multiple -m
> options.
>
> With multiple -F, I think erroring out would be the sensible
> thing to do, but some people might prefer concatenation.  I do
> not care either way as long as commit and tag behave
> consistently.

Then, Kristian, what are you willing to do in such case?
It seems easier for me to concatenate of -m and -F options, even when
both types are given. I don't know why "people" want multiple -m options,
but I think that mixing -m and -F options could be interesting for them too.
If someone know if this have been discussed and decided already,
please give me the link.
