From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Fri, 08 Aug 2014 19:37:02 +0530
Message-ID: <53E4D986.6040708@gmail.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>	<vpqy4v1vdui.fsf@anie.imag.fr>	<xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>	<vpq61i4nld7.fsf@anie.imag.fr> <xmqqoavwjb3i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:07:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFkp8-0000UD-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 16:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbaHHOHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 10:07:09 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:58717 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbaHHOHI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 10:07:08 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so7396147pad.10
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=3OVMo2ewo1xl/kAH86GPRiguNQtMNrjLIFhvN3Dk8uY=;
        b=xM+fZJcwx9prx7NgwSYAzHSdOU5gpqF2FIAqUN3T+2pmi1H84Xs8BK1USI5ea3Abgh
         IOX7l/YiwyWOhPe2nlsf9p7ULAP1UtwgBRyzDIJW/OrXqsFfT2OxI7o4cUG8H+vBL//Z
         HAg1s2eTVlelFprQ8OsXba9q7+lWT5B4qibKNDVaNIXUm13l54AKyenNmoT/fmbyUMrG
         tOcMZcCjsM9YXZja8jWM9krVQBXVgj4KW5LcIx5b8nRDoIyPK5Pq395un+2bcnRaYVE7
         tZ7bL/N3rsQJpTA0K1id/66JF/UvlTQcbTgZlimNER6xIhtbWrU3KYirbI4LBdOfHSlg
         gE2w==
X-Received: by 10.68.213.74 with SMTP id nq10mr24587469pbc.4.1407506828128;
        Fri, 08 Aug 2014 07:07:08 -0700 (PDT)
Received: from [127.0.0.1] ([106.205.33.18])
        by mx.google.com with ESMTPSA id fm8sm25927404pab.28.2014.08.08.07.07.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 07:07:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqoavwjb3i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255017>

On 8/8/2014 2:01 AM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>>>> Why is this needed? Are you now using key_value_info outside config.c?
>>>> Or is it a leftover from a previous experiment?
>>>
>>> Has this been resolved in the new round?
>>
>> Tanay explained in another subthread why this was needed. For callers
>> iterating over the string_list who want to get the file/line info, they
>> need to be able to cast the void * pointer to struct key_value_info *.
> 
> For callers that want to see all the multi-values, it would be
> preferrable for the iterator to pass the filename and the linenumber
> to the callback function, instead of exposing its implementation
> detail as a single string list and telling them to pick it apart,
> no?
> 
> Not a very convincing argument, but OK for now in the sense that we
> can fix it later if we wanted to before it gets too late.
>

(cc to Ramsay)

The discussion in both threads (v8 and v9), boils down to this,
is the `key_value_info` struct really required to be declared public or should be
just an implementation detail. I will give you the context,

The usage of the above mentioned struct is only required for
git_config_get_value_multi(). With the public struct, the code flow would look
like,


-- 8< --
diff --git a/notes.c b/notes.c
index 5fe691d..b7ab115 100644
--- a/notes.c
+++ b/notes.c
@@ -961,19 +961,6 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }

-static int notes_display_config(const char *k, const char *v, void *cb)
-{
-	int *load_refs = cb;
-
-	if (*load_refs && !strcmp(k, "notes.displayref")) {
-		if (!v)
-			config_error_nonbool(k);
-		string_list_add_refs_by_glob(&display_notes_refs, v);
-	}
-
-	return 0;
-}
-
 const char *default_notes_ref(void)
 {
 	const char *notes_ref = NULL;
@@ -1041,7 +1028,9 @@ struct notes_tree **load_notes_trees(struct string_list *refs)
 void init_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
-	int load_config_refs = 0;
+	const struct string_list *values;
+	struct key_value_info *kv_info;
+	int load_config_refs = 0, i;
 	display_notes_refs.strdup_strings = 1;

 	assert(!display_notes_trees);
@@ -1058,7 +1047,21 @@ void init_display_notes(struct display_notes_opt *opt)
 			load_config_refs = 1;
 	}

-	git_config(notes_display_config, &load_config_refs);
+	if (load_config_refs) {
+		values = git_config_get_value_multi("notes.displayref");
+		if (values) {
+			for (i = 0; i < values->nr; i++) {
+				if (!values->items[i].string) {
+					kv_info = values->items[i].util;
+					config_error_nonbool("notes.displayref");
+					git_die_config_linenr("notes.displayref", kv_info->filename, kv_info->linenr);
+				}
+				else
+					string_list_add_refs_by_glob(&display_notes_refs,
+								     values->items[i].string);
+			}
+		}
+	}

 	if (opt) {
 		struct string_list_item *item;
-- 8< --

We cannot use git_die_config() here because it is applicable to the last
value for a given variable.

Alternative solution to the problem can be a helper function like this,

git_die_config_index(key, value_index, err_msg, ...) which needs the value_index for a multi valued one,

+		values = git_config_get_value_multi("notes.displayref");
+		if (values) {
+			for (i = 0; i < values->nr; i++) {
+				if (!values->items[i].string)
+					git_die_config_linenr("notes.displayref", i, "no null values allowed for :'%s'", "notes.displayref");
+				else ; /* do stuff */
+			}

A callback iterator which supplies the linenr and filename to the callback
function is not helpful, because there are many variable checks in a
git_config() call where multi valued and single valued both reside, so we cannot
use a callback iterator without adding more code cruft.

What do you think, which way seems least obtrusive, or is there an another way out?
