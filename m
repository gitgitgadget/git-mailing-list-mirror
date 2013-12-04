From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Wed, 4 Dec 2013 17:07:08 +0100
Message-ID: <CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com> <1386164583-14109-4-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 17:07:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoEzW-0001cF-JC
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 17:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786Ab3LDQHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 11:07:53 -0500
Received: from mail-wg0-f41.google.com ([74.125.82.41]:43257 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767Ab3LDQHw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 11:07:52 -0500
Received: by mail-wg0-f41.google.com with SMTP id y10so7130554wgg.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 08:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=05mLz/jw7+ck+ng7WM2KLnsxEACButOLXNbLZSpQZt4=;
        b=iZC0WpJWDTFSrnaFq0fvsUwvQg6bkcSJ+0hyAXLlcifkirnQs4oi21Dh4PDn9eoWrL
         cBzK1vRb6AaxNNBrQf0u+Xy2Tso8T5HBNYD0v7UFpe2I/IoZS1yYBcMSqOPR7Yt0ovxS
         qx3yEBJp0tDTOlTBidnXGM0BDlT8OCC8ygQoHur6Bb7GiguAJT3afcFlDleGiA0PCn+n
         4IqVfex1Nv7azdZSlxlrNkZ60bY3Ggbl9ieoeBDnT0xfROGH2k54ijFUvR4DWEvei6b4
         fef0P6dEQ1ei/sKs4ixDHCC2gBjN9RbG+PNBmNVMHQvhKL7QccLtjmmLCtvSaOFSPJLR
         91Ng==
X-Received: by 10.194.48.115 with SMTP id k19mr12972937wjn.47.1386173268401;
 Wed, 04 Dec 2013 08:07:48 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 08:07:08 -0800 (PST)
In-Reply-To: <1386164583-14109-4-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238787>

On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.com> wrote:

> Users of validate_* passing "0" might get failures on correct name
> because of coercion of "0" to false in code like:
> die_error(500, "invalid ref") unless (check_ref_format ("0"));

I would say that the problem was that validate_sth() subroutines returned
value of parameter if it was valid, which could be a problem if said value is
false-ish (e.g. validate_refname("0"), or validate_pathname("0")).

Returning undef on invalid data newer was a problem, using 'return $input;'
on valid input was, especially that validate_sth() functions were ever used
in a conditional:

  if (!validate_sth($param)) {
      die_error(...)
  }

While at it validate_sth() is not a best name for boolean predicate:
is_valid_sth() would be better, I think.

> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
>  gitweb/gitweb.perl | 45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 67415b9..3434602 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1419,63 +1419,68 @@ sub href {
>  ## validation, quoting/unquoting and escaping
>
>  sub validate_action {
> -       my $input = shift || return undef;
> -       return undef unless exists $actions{$input};
> -       return $input;
> +       my $input = shift;
> +
> +       return 0 unless defined $input;
> +       return 0 unless exists $actions{$input};
> +       return 1;
>  }

The only change that needs to be doe is replacing

           return $input;

with

           return 1;

-- 
Jakub Narebski
