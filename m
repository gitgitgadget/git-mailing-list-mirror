From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCHv2] Makefile: implement help target
Date: Tue, 28 Sep 2010 17:00:25 -0500
Message-ID: <r6bnW3ubJQeOuXWFRPisJu1hXBq3kXeHCvNe10M00ZM@cipher.nrlssc.navy.mil>
References: <AANLkTikx2tL73gJQnqjG7yp3btcZJprKLf0z9QwcAUC1@mail.gmail.com> <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Ericsson <ae@op5.se>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 00:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0iE7-0000xy-AK
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 00:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754179Ab0I1WAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 18:00:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47317 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab0I1WAi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 18:00:38 -0400
Received: by mail.nrlssc.navy.mil id o8SM0P6n012003; Tue, 28 Sep 2010 17:00:25 -0500
In-Reply-To: <4fd8b490b4badd13c0ea46408e44dc7b317dc0ed.1285706151.git.git@drmicha.warpmail.net>
X-OriginalArrivalTime: 28 Sep 2010 22:00:25.0553 (UTC) FILETIME=[8E128410:01CB5F58]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157481>

On 09/28/2010 03:38 PM, Michael J Gruber wrote:
> with automatic help text collection from lines starting with "# Help: " and
> preceding a make target.
> 
> Suggested-by: Stephen Boyd <bebarino@gmail.com>
> Helped-by: Andreas Ericsson <andreas.ericsson@op5.se>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Now how's this for portability and such? New output:
> 
> Build targets:
>     all:                Build the Git suite
>     dist:               Build git-$(GIT_VERSION).tar.gz source
>     dist-doc:           Build $(manpages).tar.gz and $(htmldocs).tar.gz
<snip>

>  Makefile |   43 +++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 41 insertions(+), 2 deletions(-)


Very nice.  Too bad we have more targets than fit in my 33-line terminal.

/bikeshed

How about this micro-tweak:

  1) Remove the colon from the targets so they sort correctly.
     i.e. so "dist" sorts before "dist-doc" and "install" sorts
          before "install-*"
  2) Add " - " prefix to description strings and reduce target
     width accordingly so we still have just as much room for
     the description string.

So the output looks like this:

Build targets:
    all                - Build the Git suite
    dist               - Build git-$(GIT_VERSION).tar.gz source
    dist-doc           - Build $(manpages).tar.gz and $(htmldocs).tar.gz
    doc                - Build man pages and HTML docs
    html               - Build HTML doc
    info               - Build info docs
    man                - Build man pages
    pdf                - Build PDF docs
    rpm                - Build source and binary RPM packages
Clean targets:
    clean              - Remove generated files but keep the configure script
    distclean          - Remove generated files and the configure script
Develop targets:
    TAGS               - Generate tags using etags
    cscope             - Generate cscope index
    tags               - Generate tags using ctags
Help targets:
    help               - Show help for main make targets
Install targets:
    install            - Install the Git suite
    install-doc        - Install man pages
    install-html       - Install HTML docs
    install-info       - Install info docs
    install-man        - Install man pages
    install-pdf        - Install PDF docs
    quick-install-doc  - Install pregenerated man pages from origin/man
    quick-install-html - Install pregenerated HTML pages from origin/html
    quick-install-man  - Install pregenerated man pages from origin/man
Test targets:
    check-docs         - Check documentation coverage
    cover_db_html      - Check test coverage and create HTML report
    coverage           - Check test coverage
    test               - Check the build by running the test suite


(Warning: copy/pasted):

diff --git a/Makefile b/Makefile
index c7f0bb7..2803aa1 100644
--- a/Makefile
+++ b/Makefile
@@ -2398,10 +2398,10 @@ help:
        @awk '/^# Help:/ { l=substr($$0,8); \
                getline; \
                j=index(l,":"); \
-               print substr(l,1,j-1), substr($$0,1,index($$0,":")), substr(l,j+2); \
+               print substr(l,1,j-1), substr($$0,1,index($$0,":")-1), substr(l,j+2); \
                }' <Makefile | sort | while read category target text; \
        do \
                test "$$category" = "$$currcat" || printf "$$category targets:\n"; \
                currcat="$$category"; \
-               printf "    %-20s%s\n" "$$target" "$$text"; \
+               printf "    %-18s - %s\n" "$$target" "$$text"; \
        done


Oh, by the way, tested and works on Solaris 10 and IRIX 6.5.

-Brandon
