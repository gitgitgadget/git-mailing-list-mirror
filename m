From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SHELL_PATH from build system in
 run_command.c:prepare_shell_cmd
Date: Sat, 31 Mar 2012 11:04:57 -0700
Message-ID: <7vwr60ir3q.fsf@alter.siamese.dyndns.org>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <20120331055520.GA7939@burratino> <7v62dkk6dl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, j.sixt@viscovery.net, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Sat Mar 31 20:05:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE2fk-0004vV-65
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 20:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615Ab2CaSFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 14:05:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751568Ab2CaSFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 14:05:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F2476559;
	Sat, 31 Mar 2012 14:05:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iO2FcMGKsxB/OTl3TxthUuaKXmI=; b=YIvGbG
	ZVyu4WhP4+ofslv0sZVQ7R35ZODstHQ2RjzHwl1Zp4Qtul6kpEU49JcP9GPzCNyU
	AG3pnes4dnGUuBx8E3OXV/1RdQ1WZcfjbTxjJCPn+SLPOxpe8kphxlUznure0DoY
	m01w/8GIuG+NwU/VJbqmqwuODhep+/AXhYUFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JUCAU4GsCHQZiXtZ9AAZ6x6cNZQPavNf
	gLa7cOvWX8Mc2r/dBJ9LLi1AScCvegXRHoEHNkh+Consd/s+JTHIx0Z2R7H/jfaZ
	dp9ZoemK3/lX58DoJ2LEi85AyNABQfAwA9cS8ys+pG5BzC0TDmanLuAKkMOlzDb0
	JeXES6YaDnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3412D6558;
	Sat, 31 Mar 2012 14:05:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC2BA6556; Sat, 31 Mar 2012
 14:04:59 -0400 (EDT)
In-Reply-To: <7v62dkk6dl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 31 Mar 2012 10:49:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07EA5616-7B5C-11E1-B580-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194459>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> ...
>> -run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH_SQ)"'
>> +run-command.sp run-command.s run-command.o: EXTRA_CPPFLAGS = \
>> +	'-DSHELL_PATH="$(SHELL_PATH_SQ)"'
>>  
>>  $(BUILT_INS): git$X
>>  	$(QUIET_BUILT_IN)$(RM) $@ && \
>
> Actually, I do not think this is sufficient, and it happens that you and I
> are in the best position to realize it ;-).
>
> Look at what is done in the Makefile for DEFAULT_EDITOR and DEFAULT_PAGER,
> and compare with what the above is doing, and think why the EDITOR/PAGER
> needs to have another level of quoting.

In other words, something like this squashed into Ben's patch...

diff --git i/Makefile w/Makefile
index dea1f15..abee43e 100644
--- i/Makefile
+++ w/Makefile
@@ -1849,6 +1849,13 @@ DEFAULT_PAGER_CQ_SQ = $(subst ','\'',$(DEFAULT_PAGER_CQ))
 BASIC_CFLAGS += -DDEFAULT_PAGER='$(DEFAULT_PAGER_CQ_SQ)'
 endif
 
+ifdef SHELL_PATH
+SHELL_PATH_CQ = "$(subst ",\",$(subst \,\\,$(SHELL_PATH)))"
+SHELL_PATH_CQ_SQ = $(subst ','\'',$(SHELL_PATH_CQ))
+
+BASIC_CFLAGS += -DSHELL_PATH='$(SHELL_PATH_CQ_SQ)'
+endif
+
 ALL_CFLAGS += $(BASIC_CFLAGS)
 ALL_LDFLAGS += $(BASIC_LDFLAGS)
 
@@ -1913,8 +1920,6 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
 
-run-command.o: EXTRA_CPPFLAGS = -DSHELL_PATH='"$(SHELL_PATH_SQ)"'
-
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln git$X $@ 2>/dev/null || \
