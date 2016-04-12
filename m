From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] send-email: detect and offer to skip backup files
Date: Tue, 12 Apr 2016 19:00:20 -0400
Message-ID: <CAPig+cToB2ZLBarhtHMR3VHfE16ypRj-drdYDmVS9NmdJ4rYuw@mail.gmail.com>
References: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 01:00:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq7IU-0001w2-6j
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 01:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbcDLXAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 19:00:30 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35244 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758896AbcDLXAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 19:00:21 -0400
Received: by mail-ig0-f193.google.com with SMTP id fn8so4381770igb.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=b1Oqv4e8hJlr5TKvpw+NZqiy/GQNJZa++evBi8C/uNc=;
        b=hOwCN9z/M3RVlmO3cz+Oc26GHj9CHKz3gm3ySjuSASci4aoYnSV6auIx3//2jtLvlE
         glx6FxqBIyqWy+2nImMsw9PAro0Rg3RNDqHXJyepkQFP4QYv4SubocBQJEaNWfe35XKC
         Ue4uYGeMe7UYxw258D3R5wKNz5FmTg6s8hzdCcimx1Ty+Y1Y4WqgtcHbAbj8Yl2M6Svv
         M4wbzxSOJku/uHdSN85cIkVUPDptY1Rl3v6RiRcI/hkJOaD69bz15O57/OeN+YoUAYyd
         LLm1Ic7mOsp3DxoK+mgsS2/zYV8Xlar4ZNjkbH0IK05wkZ/E2Bd0L/Wx18MoXvRHax8z
         Us7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=b1Oqv4e8hJlr5TKvpw+NZqiy/GQNJZa++evBi8C/uNc=;
        b=NDKIxAoccAsJQ1sXjlbjZJ0dTjO3S4a5XIeDvUgmJlzU7vMZn+UR3hDkus0ryNicMW
         INtLUwG9iQkkVzJycGuPnlwPm1GvZa5x0N2G/QQJFGhr68uHAuLGDMejgBh2whE4pFC5
         fp2rmylxR9bsyMPDm+QvC7h/nhuD704XALMQNszjpJsw9Q5DltmpxOjNr1ZLAo+0LKnr
         l0Rqz0pqJpwk+Z8ipXHOCpCkR/bzIzRObt8tE4ANt8TLFG6w7IH4vKJSPaBMwIcqtM+d
         8Nar2i/qln/LLuOInm6AyKfMHk/sLvdfG14RF+/vnRLd21lOlyXun0szzQrVH8nWK1Xf
         Iksw==
X-Gm-Message-State: AOPr4FXjrzTGkidC2wfi0uYSyBRwXVCrsCKZ+Wc177MiwXew79BCjgXkC+qLnhCpKntPINcWS5uIfs6NfHLRbg==
X-Received: by 10.50.189.233 with SMTP id gl9mr25070463igc.73.1460502020294;
 Tue, 12 Apr 2016 16:00:20 -0700 (PDT)
Received: by 10.79.139.71 with HTTP; Tue, 12 Apr 2016 16:00:20 -0700 (PDT)
In-Reply-To: <xmqqlh4io2v1.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: hn9omriVSKSp_6ooB0xap4E-rLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291308>

On Tue, Apr 12, 2016 at 6:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Diligent people save output from format-patch to files, proofread
> and edit them and then finally send the result out.  If the
> resulting files are sent out with "git send-email 0*", this ends up
> sending backup files (e.g. 0001-X.patch.backup or 0001-X.patch~)
> left by their editors next to the final version.  Sending them with
> "git send-email 0*.patch" (if format-patch was run with the standard
> suffix) would avoid such an embarrassment, but not everybody is
> careful.
>
> After collecting files to be sent (and sorting them if read from a
> directory), notice when the file being sent out has the same name as
> the previous file, plus some suffix (e.g. 0001-X.patch was sent, and
> we are looking at 0001-X.patch.backup or 0001-X.patch~), and the
> suffix begins with a non-alnum (e.g. ".backup" or "~") and ask if
> the user really wants to send it out.  Once the user skips sending
> such a "backup" file, remember the suffix and stop asking the same
> question (e.g. after skipping 0001-X.patch~, skip 0002-Y.patch~
> without asking).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/git-send-email.perl b/git-send-email.perl
> +sub handle_backup {
> +       my ($last, $lastlen, $file, $known_suffix) = @_;
> +       my ($suffix, $skip);
> +
> +       $skip = 0;
> +       if (defined $last &&
> +           ($lastlen < length($file)) &&
> +           (substr($file, 0, $lastlen) eq $last) &&
> +           ($suffix = substr($file, $lastlen)) !~ /^[a-z0-9]/i) {
> +               if (defined $known_suffix && $suffix eq $known_suffix) {
> +                       print "Skipping $file with backup suffix '$known_suffix'.\n";
> +                       $skip = 1;
> +               } else {
> +                       my $answer = ask("Do you really want to send $file? (y|N): ",
> +                                        valid_re => qr/^(?:y|n)/i,
> +                                        default => 'y');

I still have the same question[1] as last time I reviewed this patch:
Should default be 'n', or am I misunderstanding?

[1]: http://thread.gmane.org/gmane.comp.version-control.git/289063/focus=289197

> +                       $skip = ($answer ne 'y');
> +                       if ($skip) {
> +                               $known_suffix = $suffix;
> +                       }
> +               }
> +       }
> +       return ($skip, $known_suffix);
> +}
> +
> +sub handle_backup_files {
> +       my @file = @_;
> +       my ($last, $lastlen, $known_suffix, $skip, @result);
> +       for my $file (@file) {
> +               ($skip, $known_suffix) = handle_backup($last, $lastlen,
> +                                                      $file, $known_suffix);
> +               push @result, $file unless $skip;
> +               $last = $file;
> +               $lastlen = length($file);
> +       }
> +       return @result;
> +}
> +
>  sub file_has_nonascii {
>         my $fn = shift;
>         open(my $fh, '<', $fn)
> --
> 2.8.1-347-g322afaf
