From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #03; Wed, 16)
Date: Fri, 18 Oct 2013 21:37:18 +0200
Message-ID: <52618DEE.6010000@web.de>
References: <xmqqa9i851t8.fsf@gitster.dls.corp.google.com>	<525FB287.7020204@gmail.com>	<xmqqzjq7y6k7.fsf@gitster.dls.corp.google.com> <xmqqmwm7y5bf.fsf@gitster.dls.corp.google.com> <526083E7.6080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 21:37:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXFrV-0004Aq-4O
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 21:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab3JRThZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 15:37:25 -0400
Received: from mout.web.de ([212.227.17.11]:52232 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757224Ab3JRThY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 15:37:24 -0400
Received: from [192.168.178.41] ([91.3.185.187]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MNx4F-1Ve8gD484Z-007Vsp for <git@vger.kernel.org>;
 Fri, 18 Oct 2013 21:37:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <526083E7.6080701@gmail.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:Nhk0VFBMX3ieYAQc0xNTAWwELvT/pAgeuWddmaRG2GXO6Y4OTaY
 SQUazvawr6kzsaXINHuSkcKxgDJupQbCtS87hw0am+o7D1UoV8yStKoN0xf1H20nwaUeyVA
 vzLbHMFnqbDPFVo4YkN5/eWFXFC2h2/rQpaVppDhECGwVS+rImdzuuVOJosiuekWrmUJkRB
 WnH8/+A5bdKnTONarntuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236367>

Am 18.10.2013 02:42, schrieb Karsten Blees:
> Am 17.10.2013 23:07, schrieb Junio C Hamano:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Karsten Blees <karsten.blees@gmail.com> writes:
>>>
>>>> Am 16.10.2013 23:43, schrieb Junio C Hamano:
>>>>> * kb/fast-hashmap (2013-09-25) 6 commits
>>>>>  - fixup! diffcore-rename.c: simplify finding exact renames
>>>>>  - diffcore-rename.c: use new hash map implementation
>>>>>  - diffcore-rename.c: simplify finding exact renames
>>>>>  - diffcore-rename.c: move code around to prepare for the next patch
>>>>>  - buitin/describe.c: use new hash map implementation
>>>>>  - add a hashtable implementation that supports O(1) removal
>>>>>
>>>>
>>>> I posted a much more complete v3 [1], but somehow missed Jonathan's fixup! commit.
>>>
>>> Thanks; I'll replace the above with v3 and squash the fix-up in.
>>
>> Interestingly, v3 applied on 'maint' and then merged to 'master'
>> seems to break t3600 and t7001 with a coredump.
>>
>> It would conflict with es/name-hash-no-trailing-slash-in-dirs that
>> has been cooking in 'next', too; the resolution might be trivial but
>> I didn't look too deeply into it.
>>
> 
> I've pushed a rebased version to https://github.com/kblees/git/commits/kb/hashmap-v3-next
> (no changes yet except for Jonathan's fixup in #04 and merge resolution).
> 
> The coredumps are caused by my patch #10, which free()s cache_entries when they are removed, in combination with submodule.c::stage_updated_gitmodules (5fee9952 "submodule.c: add .gitmodules staging helper functions"), which removes a cache_entry, then modifies and re-adds the (now) free()d memory.
> 
> Can't we just use add_file_to_cache here (which replaces cache_entries by creating a copy)?

No objections from my side. Looks like we could also copy the
cache entry just before remove_cache_entry_at() and use that
copy afterwards, but your solution is so much shorter that I
would really like to use it (unless someone more cache-savvy
than me has any objections).

And by the way: this is the last use of remove_cache_entry_at(),
would it make sense to remove that define while at it? Only the
remove_index_entry_at() function it is defined to is currently
used.

> diff --git a/submodule.c b/submodule.c
> index 1905d75..e388487 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -116,30 +116,7 @@ int remove_path_from_gitmodules(const char *path)
>  
>  void stage_updated_gitmodules(void)
>  {
> -       struct strbuf buf = STRBUF_INIT;
> -       struct stat st;
> -       int pos;
> -       struct cache_entry *ce;
> -       int namelen = strlen(".gitmodules");
> -
> -       pos = cache_name_pos(".gitmodules", namelen);
> -       if (pos < 0) {
> -               warning(_("could not find .gitmodules in index"));
> -               return;
> -       }
> -       ce = active_cache[pos];
> -       ce->ce_flags = namelen;
> -       if (strbuf_read_file(&buf, ".gitmodules", 0) < 0)
> -               die(_("reading updated .gitmodules failed"));
> -       if (lstat(".gitmodules", &st) < 0)
> -               die_errno(_("unable to stat updated .gitmodules"));
> -       fill_stat_cache_info(ce, &st);
> -       ce->ce_mode = ce_mode_from_stat(ce, st.st_mode);
> -       if (remove_cache_entry_at(pos) < 0)
> -               die(_("unable to remove .gitmodules from index"));
> -       if (write_sha1_file(buf.buf, buf.len, blob_type, ce->sha1))
> -               die(_("adding updated .gitmodules failed"));
> -       if (add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
> +       if (add_file_to_cache(".gitmodules", 0))
>                 die(_("staging updated .gitmodules failed"));
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
