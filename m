From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] build: generate test scripts
Date: Fri, 7 Jun 2013 17:33:10 -0500
Message-ID: <CAMP44s2N7AjpyK325FK5zWMnO4oausF3xiNmcfoqvNtxJ7DUEg@mail.gmail.com>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
	<1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
	<7v1u8dsghd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:36:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5H2-0002Xl-F9
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578Ab3FGWgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:36:40 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:64555 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756919Ab3FGWdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:33:12 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so4166048lab.4
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sivVOXQFJXXJujIs+HfYX99LCU+WZhLV19r2Yz0NYcM=;
        b=LkjRt/zuKM0MxYcGEfGaVj9/VUgTKE6qjYVoSieVefClhkArx5Cq6/tKjsPjyrVSwo
         LLJAmpsbuTUeorZ1LSNDG/RMxVqSbXNC9qUV9SNCzTbaIB08gVEu4/GeTZNqF0E3c0Ve
         qsfS9trouvKHzwb6Ute/DqMFGEltX52qiFWkRmekQLHv/0QOSD7+UtjYskVOGkRGo0TP
         UGsmPaqgABGbrghoyfp6GWnMFv2PO4Hh0cC2yI45UKI9NjZlbnqM1i9cANE+jenk6zy1
         VXX7CMZQrCehaUJEl9ozfk2GknkeyTEQGoK9lJw3JB+IDMc9e6csIk13V5iiHIaVpFe3
         AQKg==
X-Received: by 10.112.16.163 with SMTP id h3mr2076765lbd.85.1370644390725;
 Fri, 07 Jun 2013 15:33:10 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 15:33:10 -0700 (PDT)
In-Reply-To: <7v1u8dsghd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226759>

On Fri, Jun 7, 2013 at 5:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, Jun 7, 2013 at 5:03 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>
>>> -all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
>>> +all:: $(ALL_PROGRAMS) $(SCRIPTS_GEN) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
>>
>> Alternatively, we could add $(NO_INSTALL) here.
>
> As ALL_PROGRAMS overlap with most of SCRIPTS_GEN, the above looks
> overly heavy-fisted.  I tend to agree that a separate
>
>         all:: $(NO_INSTALL)
>
> would be much better, assuming that NO_INSTALL will mean "We always
> want to build these, but we never do not want to install them"
> forever (which I am OK to assume).
>
> Also
>
>         make clean
>         make --test=5800 test
>
> did not fail for me, and it turns out that "clean" somehow fails to
> clean git-remote-testpy script.
>
> As git-remote-testpy is only for testing, another possibility is to
> do
>
>     -all:: $(TEST_PROGRAMS) $(test_bindir_programs)
>     +all:: $(TEST_PROGRAMS) $(test_bindir_programs) git-remote-testpy
>
> but I think $(NO_INSTALL) is the cleanest.
>
> Perhaps like this?
>
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index a748133..03fda50 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2239,6 +2239,7 @@ endif
>
>  test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
>
> +all:: $(NO_INSTALL)
>  all:: $(TEST_PROGRAMS) $(test_bindir_programs)
>
>  bin-wrappers/%: wrap-for-bin.sh
> @@ -2489,7 +2490,7 @@ clean: profile-clean coverage-clean
>         $(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
>                 builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
>         $(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
> -       $(RM) $(TEST_PROGRAMS)
> +       $(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
>         $(RM) -r bin-wrappers $(dep_dirs)
>         $(RM) -r po/build/
>         $(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*

Looks good to me.

-- 
Felipe Contreras
