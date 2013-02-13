From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Wed, 13 Feb 2013 20:33:09 +0100
Message-ID: <511BEA75.6000002@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 20:33:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5i5V-0005Pp-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 20:33:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933947Ab3BMTdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 14:33:23 -0500
Received: from mout.web.de ([212.227.15.3]:53008 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754606Ab3BMTdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 14:33:21 -0500
Received: from [192.168.178.41] ([91.3.190.170]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0MIeUW-1U3V9U47jc-002hBX; Wed, 13 Feb 2013 20:33:16
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CABURp0oQcPotK20QcqCG1pGQPVoa4RnN2nDA=iQoKS99gnPEAQ@mail.gmail.com>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:CGNcy3hwLGe2DxRmUIPd0ZHqTstnxF8eFbPVJCba/J5
 pOFfdksERo8h3e6cKklml5AnKW3EfNLVsdadrtFPZerHHTdVzN
 SPCeR6TVrDp/lOkOLlARoZxDZMFu+C0BWXTOzMmdpm7/XLa0Y5
 +kBHMOviDQWqHn3uouAWvgDnQsU0HHv5ObIW3XJBDGQYYTkg1v
 KYhy0oFKymsaBEDVysOkQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216276>

Am 12.02.2013 18:11, schrieb Phil Hord:
> On Wed, Feb 6, 2013 at 4:11 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> +               die_if_unmatched "$mode"
>> +               name=$(module_name "$sm_path") || exit
>> +               url=$(git config submodule."$name".url)
>> +               if test -z "$url"
>> +               then
>> +                       say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
> 
> Is it safe to shelter the user a little bit more from the git
> internals here and say instead:
> 
>    Submodule '\$sm_path' is not initialized.

Yeah, that makes much more sense. But I'd rather use the name too:

   Submodule '\$name' is not initialized for path '\$sm_path'

> Also, I think this code will show this message for each submodule on
> 'git submodule deinit .'  But I think I would prefer to suppress it in
> that case.  If I have not explicitly stated which submodules to
> deinit, then I do not think git should complain that some of them are
> not initialized.

Yes, that message gets printed for each uninitialized submodule. We
could easily suppress that for '.', but it would be really hard to
get that right for other wildcards like 'foo*'. (And e.g. running a
"submodule update" also lists all submodules it skips because of an
"update=none" setting, so I'm not sure if it's that important here)

But if people really want that, I'd suppress that for the '.' case.
Further opinions?

>> +                       continue
>> +               fi
>> +
>> +               # Remove the submodule work tree (unless the user already did it)
>> +               if test -d "$sm_path"
>> +               then
>> +                       # Protect submodules containing a .git directory
>> +                       if test -d "$sm_path/.git"
>> +                       then
>> +                               echo >&2 "$(eval_gettext "Submodule work tree $sm_path contains a .git directory")"
>> +                               die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
> 
> I expect this is the right thing to do for now.  But I wonder if we
> can also move $sm_path/.git to $GIT_DIR/modules/$sm_path in this case
> (though I think I am not spelling this path correctly).  Would that be
> ok?  What extra work is needed to relocate the .git dir like this?

Hmm, I'm a bit torn about automagically moving the repo somewhere
else. While I think it is a sane solution for most users I suspect
some users might hate us for doing that without asking (and with no
option to turn that off). What about adding a separate "git submodule
to-gitfile" command which does that and hinting that here? However I
do have the feeling that this should be done in another commit.

>> +                               die "$(eval_gettext "Submodule work tree $sm_path contains local modifications, use '-f' to discard them")"
> 
> Nit, grammar: use a semicolon instead of a comma.

Ok. And while looking at it I noticed that "$sm_path" should be
"'\$sm_path'" here, same a few lines above ... sigh

>> +test_expect_success 'set up a second submodule' '
>> +       git submodule add ./init2 example2 &&
>> +       git commit -m "submodle example2 added"
> 
> Nit: submodule is misspelled

Thanks.

Junio, this looks like a we have v5 as soon as we decide what to do
with the "not initialized" messages when '.' is used, right?

My current diff to v4 looks like this:

-------------8<-------------
diff --git a/git-submodule.sh b/git-submodule.sh
index f1b552f..27f8e12 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -591,7 +591,7 @@ cmd_deinit()
 		url=$(git config submodule."$name".url)
 		if test -z "$url"
 		then
-			say "$(eval_gettext "No url found for submodule path '\$sm_path' in .git/config")"
+			say "$(eval_gettext "Submodule '\$name' is not initialized for path '\$sm_path'")"
 			continue
 		fi

@@ -601,14 +601,14 @@ cmd_deinit()
 			# Protect submodules containing a .git directory
 			if test -d "$sm_path/.git"
 			then
-				echo >&2 "$(eval_gettext "Submodule work tree $sm_path contains a .git directory")"
+				echo >&2 "$(eval_gettext "Submodule work tree '\$sm_path' contains a .git directory")"
 				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
 			fi

 			if test -z "$force"
 			then
 				git rm -n "$sm_path" ||
-				die "$(eval_gettext "Submodule work tree $sm_path contains local modifications, use '-f' to discard them")"
+				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
 			fi
 			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
 		fi
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f54a40d..e4b0a59 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -759,7 +759,7 @@ test_expect_success 'submodule add with an existing name fails unless forced' '

 test_expect_success 'set up a second submodule' '
 	git submodule add ./init2 example2 &&
-	git commit -m "submodle example2 added"
+	git commit -m "submodule example2 added"
 '

 test_expect_success 'submodule deinit should remove the whole submodule section from .git/config' '
@@ -837,7 +837,7 @@ test_expect_success 'submodule deinit complains but does not fail when used on a
 	git submodule deinit init >actual &&
 	test_i18ngrep "Submodule .example. (.*) unregistered for path .init" actual
 	git submodule deinit init >actual &&
-	test_i18ngrep "No url found for submodule path .init. in .git/config" actual &&
+	test_i18ngrep "Submodule .example. is not initialized for path .init" actual &&
 	git submodule deinit . >actual &&
 	test_i18ngrep "Submodule .example2. (.*) unregistered for path .example2" actual
 	rmdir init example2
