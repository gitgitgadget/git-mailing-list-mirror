From: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
Subject: [PATCH 2/4] bisect: replace hardcoded "bad|good" by variables
Date: Wed, 10 Jun 2015 09:10:37 +0200 (CEST)
Message-ID: <1809967391.331411.1433920237669.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <308677275.323594.1433875347392.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:10:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2a9A-0007yT-Kw
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933378AbbFJHJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:09:57 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:50465 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933347AbbFJHJz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2015 03:09:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E757B48875;
	Wed, 10 Jun 2015 09:09:52 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pf3eAnTxBPYb; Wed, 10 Jun 2015 09:09:52 +0200 (CEST)
Received: from zm-int-mbx4.grenet.fr (zm-int-mbx4.grenet.fr [130.190.242.143])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id CD4E048800;
	Wed, 10 Jun 2015 09:09:52 +0200 (CEST)
In-Reply-To: <308677275.323594.1433875347392.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - GC43 (Win)/8.0.9_GA_6191)
Thread-Topic: bisect: replace hardcoded "bad|good" by variables
Thread-Index: 2Z6PGLPLUR55iEBgtZUsWjYEKotTDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271258>

Hi, 

Thanks for the review, 
(sorry if you received this twice)

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote: 

>> +static const char *name_bad; 
>> +static const char *name_good; 
> 
>Same remark as PATCH 2. 

After the discussion you had with Christian I think we will 
keep name_bad/good for now. 

>> - 
>> - fprintf(stderr, "The merge base %s is bad.\n" 
>> - "This means the bug has been fixed " 
>> - "between %s and [%s].\n", 
>> - bad_hex, bad_hex, good_hex); 
>> - 
>> + if (!strcmp(name_bad, "bad")) { 
>> + fprintf(stderr, "The merge base %s is bad.\n" 
>> + "This means the bug has been fixed " 
>> + "between %s and [%s].\n", 
>> + bad_hex, bad_hex, good_hex); 
>> + } 
> 
>You need an "else" here. Maybe it comes later, but as a reviewer, I want 
>to check that you did not forget it now (because I don't trust myself to 
>remember that it must be added later). 

Should I put an else {} with nothing in beetween? 

>> + name_bad = "bad"; 
>> + name_good = "good"; 
>> + } else { 
>> + strbuf_getline(&str, fp, '\n'); 
>> + name_bad = strbuf_detach(&str, NULL); 
>> + strbuf_getline(&str, fp, '\n'); 
>> + name_good = strbuf_detach(&str, NULL); 
>> + } 
> 
>I would have kept just 
> 
> name_bad = "bad"; 
> name_good = "good"; 
> 
>in this patch, and introduce BISECT_TERMS in a separate one. 

Should not I introduce BISECT_TERMS in bisect.c and git-bisect.sh 
with the same commit? I did some rebase though and now name_bad and 
name_good appears in the first commit, and read_bisect_terms in the 
second. 

>> --- a/git-bisect.sh 
>> +++ b/git-bisect.sh 
>> @@ -77,6 +77,7 @@ bisect_start() { 
>> orig_args=$(git rev-parse --sq-quote "$@") 
>> bad_seen=0 
>> eval='' 
>> + start_bad_good=0 
>> if test "z$(git rev-parse --is-bare-repository)" != zfalse 
>> then 
>> mode=--no-checkout 
>> @@ -101,6 +102,9 @@ bisect_start() { 
>> die "$(eval_gettext "'\$arg' does not appear to be a valid revision")" 
>> break 
>> } 
>> + 
>> + start_bad_good=1 
>> + 
> 
>Why do you need this variable? It seems to me that you are hardcoding 
>once more that terms can be either "good/bad" or "old/new", which you 
>tried to eliminate from the previous round. 

I answered to Junio on this too, it is because our function which create 
the bisect_terms file is not called after 
'git bisect start bad_rev good_rev'. 

>> + then 
>> + echo "$NAME_BAD" >"$GIT_DIR/BISECT_TERMS" && 
>> + echo "$NAME_GOOD" >>"$GIT_DIR/BISECT_TERMS" 
>> + fi && 
> 
>Why not do this unconditionnally? Whether terms are good/bad or old/new, 
>you can write them to BISECT_TERMS. 

Because after a git bisect start we don't yet what terms are used. 
This line is only for the case 'git bisect start bad_rev good_rev'. 

>> + fi 
>> + case "$cmd" in 
>> + bad|good) 
>> + if test ! -s "$GIT_DIR/BISECT_TERMS" 
>> + then 
>> + echo "bad" >"$GIT_DIR/BISECT_TERMS" && 
>> + echo "good" >>"$GIT_DIR/BISECT_TERMS" 
>> + fi 
>> + NAME_BAD="bad" 
>> + NAME_GOOD="good" ;; 
>> + esac ;; 
>> + esac 
>> +} 
>> + 
>> +bisect_voc () { 
>> + case "$1" in 
>> + bad) echo "bad" ;; 
>> + good) echo "good" ;; 
>> + esac 
>> +} 
> 
>It's weird to have these hardcoded "bad"/"good" when you already have 
>BISECT_TERMS in the same patch. 

bisect_voc is used to display what commands the user can do, thus the 
builtins tags. I did not find a way to not hardcode them. 

The other points have been taken into account. 
