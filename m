From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 03/19] read-cache: move index v2 specific functions to their own file
Date: Fri, 19 Jul 2013 16:53:51 +0200
Message-ID: <87ppueha80.fsf@gmail.com>
References: <1373650024-3001-1-git-send-email-t.gummerer@gmail.com> <1373650024-3001-4-git-send-email-t.gummerer@gmail.com> <CACsJy8A9E5yEQZTfw6sT+2VZfDHLx5iC-mb+otRkez7f-5Mq0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 16:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0C4R-0001YJ-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 16:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760185Ab3GSOx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 10:53:59 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:59428 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760274Ab3GSOx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 10:53:56 -0400
Received: by mail-ea0-f179.google.com with SMTP id b15so2481609eae.10
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 07:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=GJiPwRcu55KzCqbALI/1YBSmnm038u+1bCZsU1lgKOw=;
        b=Tv0hddph1dnLuGZLI8CFde5Sdd+OcSK9DiBtQrlGHJVW69B3iB1qUgKXvOmQssDktA
         xO6EUK3uek9UVNqXpAw9yPwIRJPI98rVCbr728mad3Vd2C2qLsqRDx8pN++kZHFOmfY+
         QepcXACIhdJidXwO0B2ghhmFB5PTzH9VSVA2C4rFlE+ZDG0gaDG+wwGcmr6ntrjWpLgu
         HltJq4XEM4sRDPK8boWOuI17WKKLZu18GvSd0Lsg4cTywwpOqcN2pHGcr0tFgWBp3Na/
         NhTleo5qeMmo7eem+m1D26Pk2UtanLxExmSF/YBaKM2tw5JSO6grt/+8yGEbYxTf6Tph
         akvg==
X-Received: by 10.15.41.71 with SMTP id r47mr16164800eev.63.1374245635747;
        Fri, 19 Jul 2013 07:53:55 -0700 (PDT)
Received: from localhost ([2a02:27e8:10:1047:0:dacb:1376:714a])
        by mx.google.com with ESMTPSA id w43sm28031698eez.6.2013.07.19.07.53.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 07:53:54 -0700 (PDT)
In-Reply-To: <CACsJy8A9E5yEQZTfw6sT+2VZfDHLx5iC-mb+otRkez7f-5Mq0Q@mail.gmail.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230810>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jul 13, 2013 at 12:26 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> @@ -489,8 +479,8 @@ extern void *read_blob_data_from_index(struct index_state *, const char *, unsig
>>  #define CE_MATCH_RACY_IS_DIRTY         02
>>  /* do stat comparison even if CE_SKIP_WORKTREE is true */
>>  #define CE_MATCH_IGNORE_SKIP_WORKTREE  04
>> -extern int ie_match_stat(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>> -extern int ie_modified(const struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>> +extern int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>> +extern int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
>>
>
> I would rather we keep "const struct index_state*" if we could. I
> tried putting "const" back and found that ce_match_stat_basic() calls
> set_istate_ops(), which writes to "struct index_state". Putting
> set_istate_ops() in ce_match_stat_basic() may seem convenient, but
> does not make much sense (why would a match_stat function update
> index_ops?). I think you could move it out and
>
>  - read_index calls set_istate_ops
>  - (bonus) discard_index probably should reset "version" field to zero
> and clear internal_ops
>  - the callers that use index without read_index must call
> initialize_index() or something, which in turn calls set_istate_ops.
> initialize_index() may take the preferred index version
>  - do not let update-index modifies version field directly when
> --index-version is given. Wrap it with set_index_version() or
> something, so we can do internal conversion from one version to
> another if needed
>  - remove set_istate_ops in write_index(), we may need internal_ops
> long before writing. When write_index is called, internal_ops should
> be already initialized

Ok, this makes sense.  The only thing that I'm a little worried about is
catching all code paths that need to initialize the index.  I'll
implement these suggestions in the re-roll.
