From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] build: generate test scripts
Date: Fri, 07 Jun 2013 15:28:30 -0700
Message-ID: <7v1u8dsghd.fsf@alter.siamese.dyndns.org>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
	<1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:28:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul59B-0003z3-Ih
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756667Ab3FGW2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:28:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FGW2d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:28:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 624BD26C4F;
	Fri,  7 Jun 2013 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XSw7N15Xp8wo2ikSxPpKV6cs/Cg=; b=wXOBLP
	tYNvRYLqBJbfT6B98zSTrdSdXsmpF2EbJazG53lBKXX+2uz2ESNFjYILpDDPpPcU
	BuTpcAt8P17ZR2RCTZOsePVVuutDOFoDp3AU4pzBGNajwobg+L+TXhM1SoJ4PA8d
	6nOciuqLTDXT6oU1bPEBmIEd18OAtfdSEZePM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y9ViLyWtGy7ojuPeykgW0T0SLVUnimG1
	CLCDAydoAR8jpUTkruhALenYA1jJ0uV8DMq5pSpyNowOdZ9m/noZpzMv10bIlZXT
	2Ue9Wjg1FDM8YeXjB7fGTCDMerforXOP7BQQ5jwA57XHmUyC+iLgQfwFP2O8YoNE
	6pfBfLgxFqo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5841326C4E;
	Fri,  7 Jun 2013 22:28:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1CF726C4D;
	Fri,  7 Jun 2013 22:28:31 +0000 (UTC)
In-Reply-To: <CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 7 Jun 2013 17:06:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9570C9A6-CFC1-11E2-A8F6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226755>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Jun 7, 2013 at 5:03 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> -all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
>> +all:: $(ALL_PROGRAMS) $(SCRIPTS_GEN) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
>
> Alternatively, we could add $(NO_INSTALL) here.

As ALL_PROGRAMS overlap with most of SCRIPTS_GEN, the above looks
overly heavy-fisted.  I tend to agree that a separate

	all:: $(NO_INSTALL)

would be much better, assuming that NO_INSTALL will mean "We always
want to build these, but we never do not want to install them"
forever (which I am OK to assume).

Also

	make clean
        make --test=5800 test

did not fail for me, and it turns out that "clean" somehow fails to
clean git-remote-testpy script.

As git-remote-testpy is only for testing, another possibility is to
do

    -all:: $(TEST_PROGRAMS) $(test_bindir_programs)
    +all:: $(TEST_PROGRAMS) $(test_bindir_programs) git-remote-testpy

but I think $(NO_INSTALL) is the cleanest.

Perhaps like this?

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a748133..03fda50 100644
--- a/Makefile
+++ b/Makefile
@@ -2239,6 +2239,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
+all:: $(NO_INSTALL)
 all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 
 bin-wrappers/%: wrap-for-bin.sh
@@ -2489,7 +2490,7 @@ clean: profile-clean coverage-clean
 	$(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
-	$(RM) $(TEST_PROGRAMS)
+	$(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
 	$(RM) -r bin-wrappers $(dep_dirs)
 	$(RM) -r po/build/
 	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
