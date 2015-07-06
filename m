From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 09:28:21 -0700
Message-ID: <xmqqegkl2qu2.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	<xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
	<CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Borowitz <dborowitz@google.com>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:28:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9Fs-0002D4-CD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbbGFQ2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:28:24 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37872 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbGFQ2X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:28:23 -0400
Received: by igau2 with SMTP id u2so15510695iga.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=63DndSoJPo6e8h/smFxoFD9NKmbDtPoiDWmmY1y/eOk=;
        b=CTNZ5VZ7Z3a0IPXdh7ukloIYv2zA9D20l9IWPrODty77SX6YYBstFs09LhDRD7bzdv
         pecLKywVSX9IL12dcyLM2EJjmTlnXHIy9/ahLixg74kwW76/+QVG+Vqua1ZV0mQe5taP
         wbLQ76J6bd/+qLE966k1dCM9Bl1+i5AfiI1dREzc3u0QNhF8aWA0+uOFGlYqOHECiEqJ
         0P3GPBwaHtnU654/BIQzE+FZtYQFvmGlgSS7gosIdD6XinVr+Ex3MTgPT/tElA2iGNW6
         Xg12jbQ1S8QuCYlcQ+ebywDUi+SljsmH6nQajNWbeI9rAkLIbHQutq0n86DSzoNo4aru
         +6mQ==
X-Received: by 10.42.85.73 with SMTP id p9mr34531550icl.80.1436200102536;
        Mon, 06 Jul 2015 09:28:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id w4sm9962991igl.22.2015.07.06.09.28.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 09:28:22 -0700 (PDT)
In-Reply-To: <CAJo=hJvfYfgBthFMYXnXJ6e6PVM92SsWGVNt7qNTSQH9=psGtQ@mail.gmail.com>
	(Shawn Pearce's message of "Mon, 6 Jul 2015 08:46:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273400>

Shawn Pearce <spearce@spearce.org> writes:

> push cert format is like commit or tag format. You need those LFs. We
> can't just go declare them optional because of the way pkt-line read
> function is implemented in git-core.

As I said, I view each of the packets between "push-cert" and
"push-cert-end" packets representing the meat of each line in the
cert.  The sending end takes a cert as a long multi-line string,
splits them into an array, each of whose element represents a line
in it (iow "certlines = certstring.split('\n')"), and sends them
packetised.

The receiver receives a sequence of packets, notices "push-cert"
packet, collects packets until it sees "push-cert-end" packet and
treats them as elements of this array.  pkt-line deframing process
would have to strip optional LFs to reconstruct the original array
the sender had (i.e. the above certlines array).

The receiver needs to join the array with LF to recover the long
multi-line string once it received the array.  But this LF does not
have anything to do with the optional trailing LF in pkt-line.  If
you sent the original "certlines" array via different RPC mechanism,
you need to join them together with your own LF to reconstruct the
multi-line string.
