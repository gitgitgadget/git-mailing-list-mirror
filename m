From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
	loop forever
Date: Mon, 30 Mar 2009 12:04:50 -0400
Message-ID: <76718490903300904k7e8c1054m99edb92d8d582387@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <vpqd4bzjlk1.fsf@bauges.imag.fr>
	 <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
	 <vpqwsa7gjlh.fsf@bauges.imag.fr>
	 <76718490903300845x14897599jc73f50a16b21605d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:08:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoK0D-0007qA-NE
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368AbZC3QEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 12:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbZC3QEy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:04:54 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:48981 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbZC3QEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 12:04:53 -0400
Received: by gxk4 with SMTP id 4so4435727gxk.13
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ka/MYZBNIq+vEGYJ2o+OO0fs70A1WhPFS59+W5XcSOU=;
        b=nWS6Kzb+TwX35j8rMp0f9oSj5SJRPAVZo/7f9+EfZ77pZk+gybTgFrNhrGryFXWYjg
         0s3lDC1+8Vg/eqgKFDd0NFRzSbfd5GVxIEWgpSuNa2ih18guSSB6ECWUFTQ2VJVR5NBd
         s313g5XzC5jmGPRIA1NIDZNG0N+EvRe7JFtD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C+EZrBZWHgS5aJMAts27zYDJMyy4g37ddzMkGTemGWIifxXtBV9vShJ9/qwQL59Pc4
         a15tvk9VpI81aw4N9TWLMeXXkXDzKsy1oBcO7BE0q0G3D/oWBtygvAYBXfUgbC7ZeJwD
         N72GI5qemNDCD9r5s7UGWszuEOdukuBJ06azU=
Received: by 10.150.190.18 with SMTP id n18mr10416063ybf.157.1238429090794; 
	Mon, 30 Mar 2009 09:04:50 -0700 (PDT)
In-Reply-To: <76718490903300845x14897599jc73f50a16b21605d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115170>

On Mon, Mar 30, 2009 at 11:45 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Okay, well, I figured out how to work the polish. Term::ReadLine is
> attempting to use /dev/tty for input/output, which is closed. And
> because send-email enables warnings, its attempt to do so emits the
> messages you are seeing. Can you confirm that this patch squelches the
> warnings?

Ugh, not that. This:

diff --git a/git-send-email.perl b/git-send-email.perl
index f0405c8..81240ef 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -612,6 +612,9 @@ sub ask {
        my $default = $arg{default};
        my $resp;
        my $i = 0;
+       return defined $default ? $default : undef
+               unless defined $term->IN and defined fileno($term->IN) and
+                      defined $term->OUT and defined fileno($term->OUT);
        while ($i++ < 10) {
                $resp = $term->readline($prompt);
                if (!defined $resp) { # EOF

j.
