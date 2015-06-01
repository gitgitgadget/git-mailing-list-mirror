From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] send-email: allow multiple emails using --cc, --to and --bcc
Date: Mon, 01 Jun 2015 08:19:16 -0700
Message-ID: <xmqqiob78nij.fsf@gitster.dls.corp.google.com>
References: <1433168042-28269-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzRUr-0000ct-2b
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbbFAPTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:19:21 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33117 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbbFAPTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 11:19:19 -0400
Received: by igbpi8 with SMTP id pi8so63720056igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6/ZNuuo3FzGFm43aNkPYBolnj6PptwyzeMRj+lognzk=;
        b=Ph6UFwiGiWQu5pHhBW2tOLB6IBK3mBhcT3w1SkWR43MelOxhMMHCtKE+xvYJOVubkL
         ghTuCloIjTiGh5BfQBGid6bn1H2OmSkwEKGiYgel5P9VQ764an24XQc7qXkTInFx4oK5
         7zZyFPCnKArNT1Op1dqmQEfQiNOnPzRItO+lrMbPiScdeupLrtgGDVCYe+g5qrEkG65H
         jZ5nHLM8iRnsMYDxOJt32Hj2jK3n0OB1sKoYd/PlEdWWdkayiiY37wbe/NE2f3Nia/C1
         u4vTzlPGwlWtotH28LNfGKf8+RZpkcrpT7Ov6Vm8p7P2RkZ9hSEfAVvy1AOyzzbSj9Ea
         QzGg==
X-Received: by 10.42.132.6 with SMTP id b6mr29695019ict.8.1433171957815;
        Mon, 01 Jun 2015 08:19:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0e6:ec48:f0c0:da4d])
        by mx.google.com with ESMTPSA id e69sm10597498ioe.11.2015.06.01.08.19.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 08:19:17 -0700 (PDT)
In-Reply-To: <1433168042-28269-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Mon, 1 Jun 2015 16:14:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270425>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Accept a list of emails separated by commas in flags --cc, --to and
> --bcc.  Multiple addresses can already be given by using these options
> multiple times, but it is more convenient to allow cutting-and-pasting
> a list of addresses from the header of an existing e-mail message,
> which already lists them as comma-separated list, as a value to a
> single parameter.
>
> The following format can now be used:
>
>     $ git send-email --to='Jane <jdoe@example.com>, mike@example.com'
>
> However format using commas in names doesn't work:
>
>     $ git send-email --to='"Jane, Doe" <jdoe@example.com>'

That looks as if you are doing "Remi, Lespinet", which is not a good
example.  I think you want "Doe, Jane", the use of comma is when a
name is spelled in the "LastName, FirstName" order.

> diff --git a/git-send-email.perl b/git-send-email.perl
> index ffea500..389f19c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -460,20 +460,6 @@ my ($repoauthor, $repocommitter);
>  ($repoauthor) = Git::ident_person(@repo, 'author');
>  ($repocommitter) = Git::ident_person(@repo, 'committer');
>  
> -# Verify the user input
> -
> -foreach my $entry (@initial_to) {
> -	die "Comma in --to entry: $entry'\n" unless $entry !~ m/,/;
> -}
> -
> -foreach my $entry (@initial_cc) {
> -	die "Comma in --cc entry: $entry'\n" unless $entry !~ m/,/;
> -}
> -
> -foreach my $entry (@bcclist) {
> -	die "Comma in --bcclist entry: $entry'\n" unless $entry !~ m/,/;
> -}

So at this point, each element in @initial_to and friends is one
item we got from the user, e.g. "--to=<arg>", where <arg> may want
to include multiple addresses, e.g. "me, you".

And then later, in the more interesting part of the patch, I find a
puzzling code.

>  @initial_to = expand_aliases(@initial_to);
> -@initial_to = validate_address_list(sanitize_address_list(@initial_to));
> +@initial_to = extract_address_list(@initial_to);

A question: what is in @initial_to at this point in the code,
immediately before you call expand_aliases() on it?  Isn't one of
the elements be "me, you" when I said --to="me, you"?

Shouldn't you be splitting that into "me" and "you" and expand these
two as potential aliases separately?

In other words, I wonder why the patch needs to be any more complex
than this instead:

	+@initial_to = split_at_comma(@initial_to);
	 @initial_to = expand_aliases(@initial_to);
	 @initial_to = validate_address_list(sanitize_address_list(@initial_to));

As your goal is to treat --to="<address 1>, <address 2>" as if the
user said --to="<address 1>" --to="<address 2>", that would be a
more straight-forward way to enhance the system, and you shouldn't
have to change anything else, no?


>  @initial_cc = expand_aliases(@initial_cc);
> -@initial_cc = validate_address_list(sanitize_address_list(@initial_cc));
> +@initial_cc = extract_address_list(@initial_cc);
>  @bcclist = expand_aliases(@bcclist);
> -@bcclist = validate_address_list(sanitize_address_list(@bcclist));
> +@bcclist = extract_address_list(@bcclist);

Ditto.
