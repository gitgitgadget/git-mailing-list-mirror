From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Fri, 12 Jun 2015 08:07:36 -0700
Message-ID: <xmqqmw05dkxz.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
	<1434049168-10613-1-git-send-email-augie@google.com>
	<557A7ABA.2000404@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Augie Fackler <augie@google.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 17:07:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3QYb-0000rV-5z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 17:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbbFLPHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 11:07:40 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32768 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbbFLPHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 11:07:39 -0400
Received: by igbpi8 with SMTP id pi8so14572399igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RI4bBYrLbWT4EZxlVB6qanZGweCi7W4XJpG/Nks6hTk=;
        b=v6KUVJS5vAFFTkujExgtnkQkqRynxXsS5RDuVlMrQPtNyv51I2Arlion5O58B/oLFR
         RIXJZNfqfOpA5VGQaYFjT0DrrrMXcpa54nVxfuMzLl46nrErLzR3DhdtGa4MQxsncSus
         ZYbYyE9nRgqA5vslz8lwwwYxF/2hpjjF+Mr4kt0yEy6/8N18OxeVW+aSdhDnxfsv4tb+
         bsqCwtG/LqwI55Ft+yFZHCEd96ZuaGEbuTM3p/Lw6jTwyUsHx41dZwDY8QXb5VRQdcg+
         uZqCK385SSe7jlasd0Qgw546Ue5jA4JfGeC8tKPq7wQKmESHHZnUlTwxVaWxERiZW3t2
         1aaQ==
X-Received: by 10.42.81.6 with SMTP id x6mr17306831ick.89.1434121658828;
        Fri, 12 Jun 2015 08:07:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id u35sm2646167iou.7.2015.06.12.08.07.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 08:07:38 -0700 (PDT)
In-Reply-To: <557A7ABA.2000404@kdbg.org> (Johannes Sixt's message of "Fri, 12
	Jun 2015 08:22:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271491>

Johannes Sixt <j6t@kdbg.org> writes:

> What is the problem with the current fetch-pack implementation? Does
> it remove a bogus packfile after download? Does it abort during
> download when it detects a broken packfile? Does --keep not do what
> you need?

Doesn't the incoming data still go through the fattening process,
though?  You will not be able to inspect the byte-for-byte identical
stream that came out of the server end whose packfile generation
logic is suspect.

For the purpose of debugging your own new server implementation, it
might be a better approach to capture the pack as it comes out at
the server end, instead of doing it at the fetch-pack end as it
comes in. But the approach to add this "dump" at the fetch-pack side
is that it gives us a tool to diagnose problems that come from
broken server (re)implementations by other people we cannot debug,
i.e. "you are spewing this corrupt pack against this request; here
is a dump we took to help you go fix your server".

> Instead of your approach (which forks off tee to dump a copy of the
> packfile), would it not be simpler to add an option --debug-pack
> (probably not the best name) that skips the cleanup step when a broken
> packfile is detected and prints the name of the downloaded packfile?

As long as we need to debug a thin pack that comes from the other
end, that approach is not sufficient, I am afraid.

I anticipated that you'd have problem with its use of "tee".  It
probably can do this internally with async interface, perhaps,
instead?
