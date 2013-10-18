From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] submodule: don't access the .gitmodules cache entry after
 removing it
Date: Fri, 18 Oct 2013 22:31:13 +0200
Message-ID: <52619A91.7090602@web.de>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>	<525FB287.7020204@gmail.com>	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com>	<xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com>	<526083E7.6080701@gmail.com> <xmqqfvrywg4y.fsf@gitster.dls.corp.google.com> <52619183.5010608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 22:31:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXGhc-0003g5-Vc
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 22:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956Ab3JRUbQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 16:31:16 -0400
Received: from mout.web.de ([212.227.15.14]:51261 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab3JRUbP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 16:31:15 -0400
Received: from [192.168.178.41] ([91.3.185.187]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0MQ6KJ-1VbvOb1TZj-005L23 for <git@vger.kernel.org>;
 Fri, 18 Oct 2013 22:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <52619183.5010608@web.de>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:FNq3XIFPONh115dAlHh0LmZKqsfPTite9clUQJpRyoG5QaDKIAw
 zc2UCC6Kvga4mc+X1zBmGP3QbaItW57HsbHbZSnLDjKp+oPl52Gk7tAKCsvkag2h5yXpa18
 3679cWA8EFE2HeZUlZnYAYHXuNRNsM5siVCtq+EtoJyg7uS33FWkp7YymAH001oNVGDdYlW
 EhtUTCs4CjqCHwm5wfoFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236370>

Commit 5fee995244e introduced the stage_updated_gitmodules() function to
add submodule configuration updates to the index. It assumed that even
after calling remove_cache_entry_at() the same cache entry would still be
valid. This was true in the old days, as cache entries could never be
freed, but that is not so sure in the present as there is ongoing work to
free removed cache entries, which makes this code segfault.

Fix that by calling add_file_to_cache() instead of open coding it. Also
remove the "could not find .gitmodules in index" warning, as that won't
happen in regular use cases (and by then just silently adding it to the
index we do the right thing).

Thanks-to: Karsten Blees <karsten.blees@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 18.10.2013 21:52, schrieb Jens Lehmann:
> Am 18.10.2013 21:09, schrieb Junio C Hamano:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>>> Can't we just use add_file_to_cache here (which replaces
>>> cache_entries by creating a copy)?
>>>
>>> diff --git a/submodule.c b/submodule.c
>>> index 1905d75..e388487 100644
>>> --- a/submodule.c
>>> +++ b/submodule.c
>>> @@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)
>>>  
>>>  void stage_updated_gitmodules(void)
>>>  {
>>> -       struct strbuf buf = STRBUF_INIT;
>>> -       struct stat st;
>>> -       int pos;
>>> -       struct cache_entry *ce;
>>> -       int namelen = strlen(".gitmodules");
>>> -
>>> -       pos = cache_name_pos(".gitmodules", namelen);
>>> -       if (pos < 0) {
>>> -               warning(_("could not find .gitmodules in index"));
>>> -               return;
>>> -       }
>>
>> But this warning may want to stay, no?
> 
> Of course you are right on this one. All test ran successfully
> with this patch, so I think adding one for that warning makes
> sense too. And as that is submodule related stuff I volunteer
> for fixing all this ;-)

And after digging deeper and trying to come up with a test
case for that I think we can safely remove this warning too.
When not having a .gitmodules file update_path_in_gitmodules()
and remove_path_from_gitmodules() won't do anything and signal
that there is no need for stage_updated_gitmodules(). And if
we get a user later that wants to create .gitmodules file (e.g.
to register a new submodule) a warning that that file had not
been known before isn't helpful. So the only cases triggering
that warning would be when the .gitmodules is on the filesystem
but not in the index, and I can't think of a regular use case
where this happens. So let's drop it too.


 submodule.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/submodule.c b/submodule.c
index 1905d75..e388487 100644
--- a/submodule.c
+++ b/submodule.c
@@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)

 void stage_updated_gitmodules(void)
 {
-	struct strbuf buf = STRBUF_INIT;
-	struct stat st;
-	int pos;
-	struct cache_entry *ce;
-	int namelen = strlen(".gitmodules");
-
-	pos = cache_name_pos(".gitmodules", namelen);
-	if (pos < 0) {
-		warning(_("could not find .gitmodules in index"));
-		return;
-	}
-	ce = active_cache[pos];
-	ce->ce_flags = namelen;
-	if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
-		die(_("reading updated .gitmodules failed"));
-	if (lstat(".gitmodules", &st) < 0)
-		die_errno(_("unable to stat updated .gitmodules"));
-	fill_stat_cache_info(ce, &st);
-	ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
-	if (remove_cache_entry_at(pos) < 0)
-		die(_("unable to remove .gitmodules from index"));
-	if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
-		die(_("adding updated .gitmodules failed"));
-	if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
+	if (add_file_to_cache(".gitmodules", 0))
 		die(_("staging updated .gitmodules failed"));
 }

-- 
1.8.4.1.545.gc07df9e
