From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH 1/9] send-email: further document missing sendmail aliases functionality
Date: Mon, 1 Jun 2015 18:44:49 -0400
Message-ID: <CAJ80sasfCfN7e6bi7nHjLet=DWMN8kyJxMyvqu-7psFqJ0k+pA@mail.gmail.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
	<1433111371-19573-2-git-send-email-sunshine@sunshineco.com>
	<CAJ80sau0GeeFxFZYsEE=uupfPqJ=vRZfNRuNd0qRJPDNvnbMPw@mail.gmail.com>
	<20150601182236.GA28030@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 00:44:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYS0-0002Dj-QU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 00:44:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbbFAWow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 18:44:52 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:32779 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbFAWou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 18:44:50 -0400
Received: by oiww2 with SMTP id w2so112970190oiw.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 15:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=loRyiMMlPoxYGG2shksE6OGim8M92eZ8pcwUyhLu9zo=;
        b=LWT/p6kur6Rua+N3L8d4q2L671qvZa8m6bQB7eSe8+GfeXiIMyyqPMn7FNTis3TcLq
         znyymF3XyJigrN6g/B28zhYF9iT7t0FE9A1tvMFQZBPcA3rwfQd4f3NvSzT54KMa9+Gi
         PjIzq9no8/kzDH1RGDTAe1GEJ9WdxsOjCOn49sPpkM6jm5knwaL7+1d/WThnnMr0H7/D
         AxmlOhWjissGNnKQtuV1a5ULwwjnVPBX+ZExEVFMxdpX2aCYY2aAGrzekxZjit6mET3A
         4LX6OPWLgpHJhTRxOPSH8EXEGlBnkB4Sgh1lF7pSbDZXMRdC1KD6tD9VwzX83T2HZnbj
         MDVA==
X-Received: by 10.60.175.72 with SMTP id by8mr20447278oec.35.1433198689945;
 Mon, 01 Jun 2015 15:44:49 -0700 (PDT)
Received: by 10.182.117.197 with HTTP; Mon, 1 Jun 2015 15:44:49 -0700 (PDT)
In-Reply-To: <20150601182236.GA28030@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270476>

This looks good.

On Mon, Jun 1, 2015 at 2:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jun 01, 2015 at 07:43:08AM -0400, Allen Hubbe wrote:
>> On May 31, 2015 at 6:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > Sendmail aliases[1] supports expansion to a file ("/path/name") or
>> > pipe ("|command"), as well as file inclusion (":include: /path/name"),
>> > however, our implementation does not support such functionality.
>>
>> According to the documentation, the parser should print a warning for
>> any explicitly unsupported constructs.  These are now explicitly
>> unsupported, so the parser should warn on |, /, and :include: .
>> Perhaps the lines that match should be ignored like the others, too.
>
> Indeed. I had that in mind and then promptly forgot about it. Here's a
> follow-on patch:
>
> --- >8 ---
> From: Eric Sunshine <sunshine@sunshineco.com>
> Subject: [PATCH 10/9] send-email: further warn about unsupported sendmail aliases features
>
> The sendmail aliases parser diagnoses unsupported features and
> unrecognized lines. For completeness, also warn about unsupported
> redirection to "/path/name" and "|command", as well as ":include:".
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  git-send-email.perl | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index eb1d678..ae9f869 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -492,6 +492,10 @@ sub parse_sendmail_alias {
>         local $_ = shift;
>         if (/"/) {
>                 print STDERR "warning: sendmail alias with quotes is not supported: $_\n";
> +       } elsif (/:include:/) {
> +               print STDERR "warning: `:include:` not supported: $_\n";
> +       } elsif (/[\/|]/) {
> +               print STDERR "warning: `/file` or `|pipe` redirection not supported: $_\n";
>         } elsif (/^(\S+?)\s*:\s*(.+)$/) {
>                 my ($alias, $addr) = ($1, $2);
>                 $aliases{$alias} = [ split_addrs($addr) ];
> --
> 2.4.2.538.g5f4350e
>
> --- >8 ---
