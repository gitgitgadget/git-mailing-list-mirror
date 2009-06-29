From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] git mailinfo strips important context from patch subjects
Date: Mon, 29 Jun 2009 12:54:20 +0200
Message-ID: <4A489D5C.2000406@op5.se>
References: <20090628193858.GA29467@codelibre.net> <1246219664-11000-1-git-send-email-bonzini@gnu.org> <4A48870B.5050802@op5.se> <4A48959A.3060404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Roger Leigh <rleigh@codelibre.net>
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 12:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLEVO-0007DA-Hg
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 12:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757360AbZF2KyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 06:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbZF2KyX
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 06:54:23 -0400
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:38563 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753292AbZF2KyW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 06:54:22 -0400
Received: from source ([72.14.220.154]) by na3sys009aob105.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkidYJFGkniYJCEbfKBcPFyQbPaP8pKG@postini.com; Mon, 29 Jun 2009 03:54:26 PDT
Received: by fg-out-1718.google.com with SMTP id e21so567363fga.15
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 03:54:23 -0700 (PDT)
Received: by 10.86.90.8 with SMTP id n8mr506750fgb.59.1246272863854;
        Mon, 29 Jun 2009 03:54:23 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm5705033fgg.4.2009.06.29.03.54.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 03:54:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A48959A.3060404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122436>

Paolo Bonzini wrote:
> 
>>> case '[':
>>> if ((pos = strchr(subject->buf, ']'))) {
>>> remove = pos - subject->buf;
>>> - if (remove <= (subject->len - remove) * 2) {
>>> + if (remove <= subject->len * 2 / 3
>>> + && memmem(subject->buf, remove, 'PATCH', 5)) {
>>> strbuf_remove(subject, 0, remove + 1);
>>> continue;
>>> }
>>
>>
>> Pardon my ignorance, but wouldn't this still remove not only
>> "[PATCH 4/5]", but all of [PATCH 4/5] [sbuild]" anyway? The
>> parameters to strbuf_remove() seem unchanged.
> 
> I don't exclude I've screwed up, but note that pos is computed with 
> strchr, not strrchr.  Since the second memmem does not find [PATCH], it 
> does not remove anything.
> 

It removes one character, which means the subject still gets mangled. If
it *doesn't* remove one character and also doesn't break out of the loop,
it'll loop indefinitely, since *subject->buf will never change.

There's something else wrong with your patch though, as mailinfo dumps
core with it for a patch starting with "[PATCH] [git]". It happens in
memmem(). Here's the backtrace:

(gdb) bt
#0  0x00c67c76 in memmem (haystack_start=0x8a4bae0, haystack_len=6, 
    needle_start=0x41544348, needle_len=5) at memmem.c:66
#1  0x0807a1e5 in cleanup_subject () at builtin-mailinfo.c:240
#2  handle_info () at builtin-mailinfo.c:878
#3  mailinfo () at builtin-mailinfo.c:929
#4  cmd_mailinfo (argc=4, argv=<value optimized out>, prefix=0x0)
    at builtin-mailinfo.c:966
#5  0x0804b0f7 in run_builtin () at git.c:247
#6  handle_internal_command (argc=4, argv=0xbfb00f58) at git.c:393
#7  0x0804b2e2 in run_argv () at git.c:439
#8  main (argc=4, argv=0xbfb00f58) at git.c:510


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
