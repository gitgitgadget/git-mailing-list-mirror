From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't write directly to a make target ($@).
Date: Thu, 25 May 2006 18:52:01 +0200
Message-ID: <87veru3v4e.fsf@rho.meyering.net>
References: <87hd3e5ixw.fsf@rho.meyering.net>
	<7vejyixe5g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 18:52:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjJ4B-0006Bu-OJ
	for gcvg-git@gmane.org; Thu, 25 May 2006 18:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWEYQwE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 12:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWEYQwE
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 12:52:04 -0400
Received: from mx.meyering.net ([82.230.74.64]:36073 "EHLO mx.meyering.net")
	by vger.kernel.org with ESMTP id S1030276AbWEYQwD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 12:52:03 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9AD676A54; Thu, 25 May 2006 18:52:01 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vejyixe5g.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 25 May 2006 09:28:11 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20748>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Otherwise, if make is suspended, or killed with prejudice, or if the
>> system crashes, you could be left with an up-to-date, yet corrupt,
>> generated file.
>
> Thanks.  Maybe you would want a "make clean" target for them too
> if you do this.  I often use $@+ instead of t$@ so that I can
> say "rm -f *+" there.
>
>> @@ -496,37 +496,43 @@ builtin-help.o: common-cmds.h
>>  	rm -f $@ && ln git$X $@
>>
>>  common-cmds.h: Documentation/git-*.txt
>> -	./generate-cmdlist.sh > $@
>> +	./generate-cmdlist.sh > t$@
>> +	mv t$@ $@
>>
>
> IOW, like this:
>
> common-cmds.h: Documentation/git-*.txt
> 	rm -f $@+ $@
>         ./generate-cmdlist.sh > $@+
>         mv $@+ $@
>
> clean::
> 	rm -f *+

I've included a revised patch below.

I left off the `clean' addition, because I believe "make clean" should
not remove wildcard patterns like "*+", on the off-chance that someone
uses names like that for files they care about.  Besides, in practice,
those temporary files are left behind so rarely that they're not a bother,
and they're removed again as part of the next build.


---------

Subject: [PATCH] Don't write directly to a make target ($@).  Update atomically.

Otherwise, if make is killed with prejudice, or if the system crashes,
you could be left with an up-to-date, yet corrupt generated file.

---

 Makefile |   34 ++++++++++++++++++++--------------
 1 files changed, 20 insertions(+), 14 deletions(-)

620173525c5075f2056af107a85881d0d50d3a89
diff --git a/Makefile b/Makefile
index dbf19c6..04536f6 100644
--- a/Makefile
+++ b/Makefile
@@ -496,37 +496,43 @@ builtin-help.o: common-cmds.h
 	rm -f $@ && ln git$X $@
 
 common-cmds.h: Documentation/git-*.txt
-	./generate-cmdlist.sh > $@
+	./generate-cmdlist.sh > $@+
+	mv $@+ $@
 
 $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
-	rm -f $@
+	rm -f $@ $@+
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    -e 's/@@NO_PYTHON@@/$(NO_PYTHON)/g' \
-	    $@.sh >$@
-	chmod +x $@
+	    $@.sh >$@+
+	chmod +x $@+
+	mv $@+ $@
 
 $(patsubst %.perl,%,$(SCRIPT_PERL)) : % : %.perl
-	rm -f $@
+	rm -f $@ $@+
 	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@
-	chmod +x $@
+	    $@.perl >$@+
+	chmod +x $@+
+	mv $@+ $@
 
 $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % : %.py
-	rm -f $@
+	rm -f $@ $@+
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
 	    -e 's|@@GIT_PYTHON_PATH@@|$(GIT_PYTHON_DIR_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.py >$@
-	chmod +x $@
+	    $@.py >$@+
+	chmod +x $@+
+	mv $@+ $@
 
 git-cherry-pick: git-revert
-	cp $< $@
+	cp $< $@+
+	mv $@+ $@
 
 git-status: git-commit
-	cp $< $@
+	cp $< $@+
+	mv $@+ $@
 
 # These can record GIT_VERSION
 git$X git.spec \
@@ -653,7 +659,8 @@ install-doc:
 ### Maintainer's dist rules
 
 git.spec: git.spec.in
-	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@
+	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
+	mv $@+ $@
 
 GIT_TARNAME=git-$(GIT_VERSION)
 dist: git.spec git-tar-tree
@@ -724,4 +731,3 @@ check-docs::
 		*) echo "no link: $$v";; \
 		esac ; \
 	done | sort
-
-- 
1.3.2
