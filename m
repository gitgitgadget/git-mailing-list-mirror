From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: detect when PYTHON_PATH changes
Date: Sat, 15 Dec 2012 21:09:50 +0100 (CET)
Message-ID: <20121215.210950.1929890617364602070.chriscool@tuxfamily.org>
References: <20121215140719.2409.27365.chriscool@tuxfamily.org>
	<7vehirustv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 15 21:10:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjy4C-00013S-C1
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 21:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818Ab2LOUKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 15:10:13 -0500
Received: from [194.158.122.56] ([194.158.122.56]:39878 "EHLO mail-1d.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751591Ab2LOUKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 15:10:12 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1d.bbox.fr (Postfix) with ESMTP id 0B104A4;
	Sat, 15 Dec 2012 21:09:50 +0100 (CET)
In-Reply-To: <7vehirustv.fsf@alter.siamese.dyndns.org>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211569>

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: detect when PYTHON_PATH changes
Date: Sat, 15 Dec 2012 09:29:48 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> @@ -2636,6 +2636,18 @@ GIT-GUI-VARS: FORCE
>>              fi
>>  endif
>>  
>> +### Detect Python interpreter path changes
>> +ifndef NO_PYTHON
>> +TRACK_VARS = $(subst ','\'',-DPYTHON_PATH='$(PYTHON_PATH_SQ)')
>> +
>> +GIT-PYTHON-VARS: FORCE
>> +	@VARS='$(TRACK_VARS)'; \
>> +	    if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
>> +		echo 1>&2 "    * new Python interpreter location"; \
>> +		echo "$$VARS" >$@; \
>> +            fi
>> +endif
> 
> Do we have the same issue when you decide to use /usr/local/bin/sh
> after building with /bin/sh set to SHELL_PATH?
> 
>  - If yes, I presume that there will be follow-up patches to this
>    one, for SHELL_PATH, PERL_PATH, and TCLTK_PATH (there may be
>    other languages but I didn't bother to check).  How would the use
>    of language agnostic looking TRACK_VARS variable in this patch
>    affect such follow-up patches?

Actually, just above the above hunk, there is:

### Detect Tck/Tk interpreter path changes
ifndef NO_TCLTK
TRACK_VARS = $(subst ','\'',-DTCLTK_PATH='$(TCLTK_PATH_SQ)')

GIT-GUI-VARS: FORCE
        @VARS='$(TRACK_VARS)'; \
            if test x"$$VARS" != x"`cat $@ 2>/dev/null`" ; then \
                echo 1>&2 "    * new Tcl/Tk interpreter location"; \
                echo "$$VARS" >$@; \
            fi
endif

But you are right, TRACK_VARS should probably be something like
TRACK_TCLTK when used for TCLTK and TRACK_PYTHON when used for Python.

By the way it looks like GIT-GUI-VARS is not used, so perhaps the
detection of Tck/Tk interpreter path changes above could be removed.

(The detection is done in git-gui/Makefile too.)

About shell, there is the following:

SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
        $(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
        $(gitwebdir_SQ):$(PERL_PATH_SQ)

and then

GIT-SCRIPT-DEFINES: FORCE
        @FLAGS='$(SCRIPT_DEFINES)'; \
            if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
                echo 1>&2 "    * new script parameters"; \
                echo "$$FLAGS" >$@; \
            fi


$(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh GIT-SCRIPT-DEFINES
        $(QUIET_GEN)$(cmd_munge_script) && \
        chmod +x $@+ && \
        mv $@+ $@

$(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
        $(QUIET_GEN)$(cmd_munge_script) && \
        mv $@+ $@

So it looks to me that at least for SHELL_PATH, things are done
properly. 

>  - If no (in other words, if we rebuild shell-scripted porcelains
>    when SHELL_PATH changes), wouldn't it be better to see how it is
>    done and hook into the same mechanism?

You would like me to just add $(PYTHON_PATH_SQ) in SCRIPT_DEFINES and
then use GIT-SCRIPT-DEFINES instead of GIT-PYTHON-VARS to decide if
python scripts should be rebuilt?

>  - If no, and if the approach taken in this patch is better than the
>    one used to rebuild shell scripts (it may limit the scope of
>    rebuilding when path changes, or something, but again, I didn't
>    bother to check), 

Yeah, I think it is better because it limits the scope of rebuilding,
and because nothing is done for Python, while there are some
mechanisms in place for other languages.

> then again follow-up patches to this one to
>    describe dependencies to build scripts in other languages in a
>    similar way to this patch would come in the future.  The same
>    question regarding TRACK_VARS applies in this case.

I agree about TRACK_VARS. About other languages, I will have another
look, but it seems that they already have what they need.

> By the way, "1>&2" is easier to read if written as just ">&2", I
> think.

Ok I will change this.

Thanks,
Christian.
