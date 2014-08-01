From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 6/7] config: add `git_die_config()` to the config-set API
Date: Fri, 01 Aug 2014 11:22:57 +0200
Message-ID: <vpqlhr836oe.fsf@anie.imag.fr>
References: <1406821662-1570-1-git-send-email-tanayabh@gmail.com>
	<1406821662-1570-7-git-send-email-tanayabh@gmail.com>
	<vpqr411h69h.fsf@anie.imag.fr> <53DA7281.8060403@gmail.com>
	<vpqr411bhd5.fsf@anie.imag.fr> <53DA7C23.3090603@gmail.com>
	<vpqa97p8koq.fsf@anie.imag.fr> <53DA8A54.6060208@gmail.com>
	<vpqoaw55q16.fsf@anie.imag.fr> <53DB582F.8040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 11:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD93T-0000g0-3c
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 11:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbaHAJXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 05:23:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53848 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaHAJXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 05:23:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s719MuUs003593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2014 11:22:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s719MvVp009841;
	Fri, 1 Aug 2014 11:22:57 +0200
In-Reply-To: <53DB582F.8040501@gmail.com> (Tanay Abhra's message of "Fri, 01
	Aug 2014 14:34:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 01 Aug 2014 11:22:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s719MuUs003593
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407489780.50551@jSaVO2Na7TvCmmAWYKJX7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254625>

Tanay Abhra <tanayabh@gmail.com> writes:

> Thanks, I am sending your version with the reroll.
> Also, for clarity the multi value use case would look like,
>
> 	struct key_value_info *kv_info;
> 	if (load_config_refs) {
> 		values = git_config_get_value_multi("notes.displayref");
> 		if (values) {
> 			for (i = 0; i < values->nr; i++) {
> 				if (!values->items[i].string) {
> 					config_error_nonbool("notes.displayref");
> 					kv_info = values->items[i].util;
> 					git_die_config_linenr("notes.displayref",
> 							      kv_info->filename,
> 							      kv_info->linenr);
> 				}
> 				else
> 					string_list_add_refs_by_glob(&display_notes_refs,
> 								     values->items[i].string);
> 			}
> 		}
> 	}
>
> with my function it would have looked like,
>
> 	if (load_config_refs) {
> 		values = git_config_get_value_multi("notes.displayref");
> 		if (values) {
> 			for (i = 0; i < values->nr; i++) {
> 				if (!values->items[i].string) {
> 					config_error_nonbool("notes.displayref");
> 					git_die_config_exact("notes.displayref", values->items[i].string);
> 				}
> 				else
> 					string_list_add_refs_by_glob(&display_notes_refs,
> 								     values->items[i].string);
> 			}
> 		}
> 	}

I still think that checking for non-null values should be done in a
helper in config.c, and then the code would look like

 	if (load_config_refs) {
 		values = git_config_get_value_multi_nonbool("notes.displayref");
 		if (values)
 			for (i = 0; i < values->nr; i++)
				string_list_add_refs_by_glob(&display_notes_refs,
							     values->items[i].string);
 	}

The same helper could at least be used for "branch.<remote>.merge".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
