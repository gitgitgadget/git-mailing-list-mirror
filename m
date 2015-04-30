From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: rebase -i's todo/done list, was Re: [PATCH] rebase -i: redo tasks
 that die during cherry-pick
Date: Thu, 30 Apr 2015 09:49:40 +0200
Organization: gmx
Message-ID: <66567923994761429d29715508bc415f@www.dscho.org>
References: <1430261720-9051-1-git-send-email-hordp@cisco.com>
 <42512fad738e0ec47a8cdb6e6e92e994@www.dscho.org>
 <xmqq7fsu6ek4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	phil.hord@gmail.com, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 09:49:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnjEG-0001iH-CM
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 09:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbbD3Htt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 03:49:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:58909 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750946AbbD3Htr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 03:49:47 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LaGJa-1ZZSO310iE-00m0qL; Thu, 30 Apr 2015 09:49:41
 +0200
In-Reply-To: <xmqq7fsu6ek4.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:5dRuliBaqNJa4h5bzF/J/AotKsaIk549Ux8g26H+SZO4KfdCMcf
 bCeYxozTXUzObEmHXX3qjnnR2wV7rPzI0UAGs+jGKPvyxgGGvCp4RbYHF4DU6nNoXErygo4
 3eQ9WxXZ09R8qPJ0atGBIluZw1jWLZj0gsMI4rDFKnikzkSZKzqbLAODexCx9BiNHEsMALz
 62YtHUcOrmN3vJX+sVwmA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268059>

Hi Junio,

On 2015-04-29 19:15, Junio C Hamano wrote:

> [I] wonder if it would have been a better design to have a static "todo" with a "current" pointer as two state files.

I decided against this in my original design because I frequently edited the todo list during the rebase run, already back when I had still called it `edit-patch-series.sh` (you will remember that "Saturday project" I reported on IRC).

One example for such an editing happens to me quite frequently: I reorder patches into a more logical order, except that I make mistakes and try to pull a patch too early, i.e. before the code it touches was added. In such a case, I obviously get a merge conflict, and after analysing the problem I have a better idea where to put that patch, which I do by adding a "pick deadbeef" into the `git-rebase-todo` list (these days, I use `git rebase --edit-todo`, of course).

If the list and the "current" pointer would be two different things, it would be way too easy to incur inconsistencies. Even for the inventor of rebase -i.

> Then reschedule would have been just the matter of decrementing the number in "current", instead of "grab the last line of one file and prepend to the other file, and then lose the last line".

I think that is only an implementation detail: whether we decrement a pointer or put back a line we moved to another file is essentially the same operation: it is a roll-back. The "more invasive" change I implied was to *avoid* the need for a roll-back, i.e. only move that line (or in your example, increment the pointer) after the operation completed successfully.

My implied change would mean that all the `mark_action_done` calls would have to be moved just before the `record_in_rewritten` calls -- but not all actions have that call. The tricky bit is that there are side effects: `peek_next_command` relies on the current behavior and would have to be adjusted. And that is only the side effect that I can think of off the top of my head.

Ciao,
Dscho
