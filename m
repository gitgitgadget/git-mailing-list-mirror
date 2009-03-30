From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
	loop forever
Date: Mon, 30 Mar 2009 11:45:16 -0400
Message-ID: <76718490903300845x14897599jc73f50a16b21605d@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
	 <vpqd4bzjlk1.fsf@bauges.imag.fr>
	 <76718490903300717x5cc5e33ax1cf91471efd242bd@mail.gmail.com>
	 <vpqwsa7gjlh.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 30 17:47:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoJhP-0007rf-6x
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 17:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZC3PpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 11:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbZC3PpT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 11:45:19 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:7540 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbZC3PpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 11:45:18 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2024278yxl.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2009 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r+Ik97fgtuiQCFA1QBaVL0aoALA+IfKUJh/Z71I7gRU=;
        b=JzRR83lgTXyH0a06OtdZ0+20m7ptj/M4Sch3Etwyhrs+oTA6wVwOCwBPCOvW1tYylq
         +K4LTmJB8/+ZZJkhiGCrwx9fWNPYOdaR8bwajw988mo+5TjDmVpETbm8LroNg0LLNLGn
         9we5941NFM749kbHaJyZS/UPr+WgNIpavENT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nEQMHwFkPs/Pt2h1nGhkBYvPqkmc2iyIq3o2y/7CjMk6ysix0VvE3FKp/X2QDGg8sh
         gce/eBdz5NQ2QrC9mIPTPp2430Tk5DppGmsJSuOPyJEkDItMwbDHCefirVvcVUMmqekq
         sFKvtXTvNNrIlpeE60Lapxh6q/kPg/tmkLots=
Received: by 10.150.218.10 with SMTP id q10mr10707901ybg.11.1238427916248; 
	Mon, 30 Mar 2009 08:45:16 -0700 (PDT)
In-Reply-To: <vpqwsa7gjlh.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115165>

On Mon, Mar 30, 2009 at 10:40 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>> Seriously though, I am unable to reproduce the messages you are
>> getting from Term::ReadLine, and I tried really hard.
>
> Anyway, as I said, the warnings do not harm. They just appear messy in
> my log files, but it's really a matter of polishing the UI.

Okay, well, I figured out how to work the polish. Term::ReadLine is
attempting to use /dev/tty for input/output, which is closed. And
because send-email enables warnings, its attempt to do so emits the
messages you are seeing. Can you confirm that this patch squelches the
warnings?

diff --git a/git-send-email.perl b/git-send-email.perl
index f0405c8..1b17728 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -612,6 +612,8 @@ sub ask {
        my $default = $arg{default};
        my $resp;
        my $i = 0;
+       return undef unless defined fileno($term->IN) and
+                           defined fileno($term->OUT);
        while ($i++ < 10) {
                $resp = $term->readline($prompt);
                if (!defined $resp) { # EOF


Thanks,

j.
