From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] gitweb: Add an option for adding more branch refs
Date: Wed, 27 Nov 2013 15:34:49 -0500
Message-ID: <CAPig+cT=P3ZC9j-WwQjr7gu6RrNgLrXsPkiVmdy5OGYfu8mPqA@mail.gmail.com>
References: <1385566221-7977-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 21:34:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vllp1-0005sd-US
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 21:34:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757418Ab3K0Uew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 15:34:52 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:53948 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab3K0Uev (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 15:34:51 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so12479835iec.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2013 12:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7UbG0uDupb1uXgiPiEaNB63HwkTknB0TP1lmzCPnt14=;
        b=XqPBu6Mkr45qXGPZcTej9dcjhbUMGXZ0VCsoP/gxThsfCjiOoZF/L1ge0uM7bMHmy4
         sAWvtUT7H8prIaPNlpyU1cdOvs4CsN/gYLgJ3N5DVIiqQsGSA1fd8KHM1QVb7VQ7J3Mh
         h/jBheV3/sNsVLa191zVbqJrdGgpgBPpPV3LeI+Hj1JLBC7IMAHWPsvSaBm4v/glmAAD
         Yqld+KxCnGC5MiUQaXJE3TFDHCwp8hvRLashclIP+N+1WXrTOg411/QtIXj3B1njcBTn
         i7RlF+s8ezrfnWzwF+JmWVRBrdG5HOrB8CElwBo7Y8ZXbDjwu6oVKP5a1j2hHizfdeIL
         /VZw==
X-Received: by 10.50.176.201 with SMTP id ck9mr23157355igc.46.1385584489924;
 Wed, 27 Nov 2013 12:34:49 -0800 (PST)
Received: by 10.64.250.198 with HTTP; Wed, 27 Nov 2013 12:34:49 -0800 (PST)
In-Reply-To: <1385566221-7977-1-git-send-email-krzesimir@endocode.com>
X-Google-Sender-Auth: 9EfAyka-y_Ymo4O7k9fUqUFQJ90
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238462>

On Wed, Nov 27, 2013 at 10:30 AM, Krzesimir Nowak
<krzesimir@endocode.com> wrote:
> Overriding an @additional_branch_refs configuration variable with
> value ('wip') will make gitweb to show branches that appear in
> refs/heads and refs/wip (refs/heads is hardcoded). Might be useful for
> gerrit setups where user branches are not stored under refs/heads/.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..499281b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -680,6 +688,19 @@ sub read_config_file {
>         return;
>  }
>
> +# performs sanity checks on parts of configuration.
> +sub config_sanity_check {
> +       # check additional refs validity
> +       my %unique_branch_refs = ();
> +       for my $ref (@additional_branch_refs) {
> +               die_error(500, 'Invalid ref in @additional_branch_refs') unless (validate_ref($ref));

Mentioning $ref in the error message would help the user resolve the
problem more quickly.

> +               die_error(500, '"heads" specified in @additional_branch_refs') if ($ref eq 'heads');

Rephrasing this as

    "heads" disallowed in @additional_branch_refs

would better explain the problem to a user who has only made a cursory
read of the documentation.

> +               die_error(500, "Ref '$ref' repeated in \@additional_branch_refs") if (exists $unique_branch_refs{$ref});
> +               $unique_branch_refs{$ref} = 1;
> +       }
> +       %unique_branch_refs = undef;
> +}
> +
>  our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON);
>  sub evaluate_gitweb_config {
>         our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
