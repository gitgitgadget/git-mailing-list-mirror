From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Thu, 28 Nov 2013 20:13:42 -0500
Message-ID: <CAPig+cSjzpSatp9EhpwA9b_XScAPUpkMxmPo70qJCxxakMwq3Q@mail.gmail.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Fri Nov 29 02:13:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmCeS-0006uH-DW
	for gcvg-git-2@plane.gmane.org; Fri, 29 Nov 2013 02:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250Ab3K2BNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 20:13:44 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:57148 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3K2BNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 20:13:43 -0500
Received: by mail-lb0-f182.google.com with SMTP id u14so6521119lbd.41
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 17:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uPlIpfsjHL9QGRxO7h+zu3+drjg2PBiu8rcT8+muby4=;
        b=IgRUpEgaJm+zTtxCezoU7k9bwCk4YWMqC8lf0xSmVP46JJtNVacoYp4YnBrincol//
         nNYv91qQkTwdfxQjDmdz/jsdhHqR+cE9HJeuFrijd0KPo3eC+uZuzWJio204CqxzUGhU
         z8dBuGEvsKy5/BVJegSKL+eNqYSlSgX5IY3DLzbQgS3L/A1Omvq1oTRKKnOReum8QxBd
         q2Ag1ZX1+ldsGYeJx+bfx2mHU03yfKVjdCg52CQ5zqTbd6TKydKQhPmRFh6AlSzagwO3
         AJt79Lg2hS2w+dhHzcEp0WQGrVH6687l4SLvBAyJQjykyFtW9DXQita/dFybdeOrculA
         zQ3w==
X-Received: by 10.152.120.102 with SMTP id lb6mr338057lab.37.1385687622108;
 Thu, 28 Nov 2013 17:13:42 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Thu, 28 Nov 2013 17:13:42 -0800 (PST)
In-Reply-To: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
X-Google-Sender-Auth: hwxnuelt8GicynRzmylLZ-rN1RY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238521>

On Thu, Nov 28, 2013 at 6:44 AM, Krzesimir Nowak <krzesimir@endocode.com> wrote:
> Allow @additional_branch_refs configuration variable to tell gitweb to
> show refs from additional hierarchies in addition to branches in the
> list-of-branches view.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> ---
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 68c77f6..25e1d37 100755
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
> +               die_error(500, "Invalid ref '$ref' in \@additional_branch_refs") unless (validate_ref($ref));
> +               # 'heads' are added implicitly in get_branch_refs().
> +               $unique_branch_refs{$ref} = 1 if ($ref ne 'heads');
> +       }
> +       @additional_branch_refs = sort keys %unique_branch_refs;
> +       %unique_branch_refs = undef;
> +}

%unique_branch_refs is going out of scope here, so clearing it seems
unnecessary.

Moreover, with warnings enabled, perl should be complaining about an
"Odd number of elements in hash assignment". (Normally, you would
clear a hash with '%foo=()' or 'undef %foo'.)

> +
>  our ($GITWEB_CONFIG, $GITWEB_CONFIG_SYSTEM, $GITWEB_CONFIG_COMMON);
>  sub evaluate_gitweb_config {
>         our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
