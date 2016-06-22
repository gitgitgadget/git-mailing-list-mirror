Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA8B1FE4E
	for <e@80x24.org>; Wed, 22 Jun 2016 09:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbcFVJMm (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 05:12:42 -0400
Received: from mout.gmx.net ([212.227.15.18]:54741 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750907AbcFVJMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 05:12:32 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M3zT0-1bWlWF0nvm-00rUut; Wed, 22 Jun 2016 11:03:53
 +0200
Date:	Wed, 22 Jun 2016 11:03:51 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: [PATCH] Make find_commit_subject() more robust
In-Reply-To: <xmqqziqent0e.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606221041320.10382@virtualbox>
References: <34ef85eb4e2aef0b342ef5d3bce9e468c8339486.1466255489.git.johannes.schindelin@gmx.de> <xmqqeg7ru00i.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1606211402320.22630@virtualbox> <xmqqziqent0e.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bAVK61PWE5k34zqyHI1TvIomvw9RUhusU8WQiq4WLas6RVrIN24
 7Nax02/57T2cc4Rz8jJ28jIhMAzAOImW83xP7PBl0WfO2M4sAqpk4zKu5jFz9BrKFTckxSD
 JZG0oZWhERbtd9Ed6RFlEo1GbEZ328U6h2oMnEoYTsaRsfJiDUYRWQ99vgPOCAmVCVrUJT8
 6GPBSfhBSjXrYlCOaAOhg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:gl123tEQiBI=:7UCCHjZYFJGgQDJhwo/bmd
 x3PPEy+im7Na0ugXaG1rkt0bx3NUD9nVIs93/pMGDiR85cJOmBDAlE/KIRcY6AJvjl2V2UzxI
 MrQnNRZF9ZeJO823rA17PKqslVfr7CSFePKPbq0DIG2Nnf4Tbg9I1ozfYsycGJHx21cmg8Kbk
 dDW2JJr3YfhXquxxKhWGecqCVfpj5lp2iA5YC2twfjJNr87qDQcg4YA9pR0gWRCPS3ohd6VZR
 7aqFMk6z0K1OdGXEC9KAckOw4M0nCEDRsnB99Y0+7WCZKWyxVY9DK3zA9FMs2LFbwYgLWn1SO
 iHzzkp2C4OMV9/BjwGygdLpvvpWZvvJefQ1G03u/EmKSXhKbhOotxX7l3/0+TGRmXVaKQEd0h
 Jg949TDSWgAQW9s4lgQuQVdEn+Ymc2FBltN+ReEm7bUDFBTg676Wz9ygEkIX2O7tov6czETRL
 clX9FD50tXiIz98CcMVtXjAJUrZxHe5+g0uHKMzh9S9zlSHknfnDzdbNI4jva5nAp8rTukQFN
 XZeCxY4BrJS/QovW4R/Cw0+d5dFHmz73sZ2Ltexy+YYmCB70cEAgracmW9QjFa4+gCZTwELvv
 X2eubpAxoXqWdtsCzO/tl3JTChc4FQDk7j1FKRJp8WHMad+F7pauoKYvWZqwGqCLqqeZoryqR
 sozhf0DHLSnGheyLZ4bkQC2cJwjccwlGkQ0RRh6J62l8wzGJL5trYSyBJ5rTpXBjS9s9DW/BJ
 JNuaxmLUI+32qOM11a83KtcCrkoOjq/ddBGhNCwLNgsjkVRhe/RRQGQrHJsseZUX3W/wW8quU
 U7hbdWI
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Tue, 21 Jun 2016, Junio C Hamano wrote:

> Your patch introduces a similar loop with similar (but different)
> purpose:
> 
> 		while (*p == '\n')
> 			p++;
> 
> which would have been helped if there were a helper with an
> opposite function, i.e.
> 
> 		p = strcchrnul(p, '\n');
> 
> i.e. "give me the pointer to the first byte that is not '\n', or EOS".
> 
> But there is no such thing.  Although p += strcspn(p, "\n") is a
> possibility, that somehow feels a bit odd.  And that is why I did
> not hint any existing function and said "might want to find".

Sure. And strcspn() is less efficient than the loop if you already know
that the second parameter contains only a single character.

> HOWEVER.
> 
> Stepping back a bit, I think what we actually want is
> 
> 		p = skip_blank_lines(p);
> 
> that skips any and all blank lines, including an empty line that
> consists of all whitespace.

My original aim was to make find_commit_subject() consistent with the
pretty-printing machinery. I failed to realize that skip_blank_lines()
does more than skipping empty lines, so let me re-roll the patch.

Ciao,
Dscho
