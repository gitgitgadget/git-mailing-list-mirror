From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2] read-cache: save index entry updates in ILOG index extension
Date: Fri, 9 Aug 2013 20:32:49 +0700
Message-ID: <CACsJy8CbS_ZCZOsGY2KoTU=tid1ZH0wDbwcpu2oy9T9RV+N+BQ@mail.gmail.com>
References: <1375597720-13236-1-git-send-email-pclouds@gmail.com>
 <1375966270-10968-1-git-send-email-pclouds@gmail.com> <7veha49g1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 15:33:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7mon-0005Gi-R4
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 15:33:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967838Ab3HINdV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 09:33:21 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:40026 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967831Ab3HINdU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 09:33:20 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so6495017obc.27
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=elgbHKDZ+PZvZOKLRQKDPqqbjbXOwV6yrRrWDisaJDM=;
        b=e/mHY3ELdB9DUWWqqo0hjkaClWccFx17gUh5n7YAcMqZIEcA6wi68HDCjKLgYmQTiv
         OmOXXpKv5ln7FLjX56w+aPTSbr1eMScLbhDNjwuoDnmj5Ipha1sPPK5AwVMjDs1cH7hd
         BL7JiQMhNpY3cM0obAqOndA2tRKnE5zTGqTdmiaSru/h3OrWE+fP2qWPD+O5ILme0kEL
         sqDlZxKYvcUR7hcOeCkMFTzQAE0WEudZ508IiHHnBpM6YR7wNH01tdR3eGkTmd2UuEi2
         X7KpAXeaf3sVCx+4aV1aT8poXbGlLBJAhOtK8q1bBF1UN064Ltxnw4v3EOk4/Eg3zVD3
         6/Xg==
X-Received: by 10.182.241.101 with SMTP id wh5mr482528obc.49.1376055199853;
 Fri, 09 Aug 2013 06:33:19 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 9 Aug 2013 06:32:49 -0700 (PDT)
In-Reply-To: <7veha49g1x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231981>

On Fri, Aug 9, 2013 at 1:46 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Old operation's updates are removed as new ones are added to keep th=
e
>> size under 1 MB. ILOG keeps minimum 10 operations regardless of its
>> size. These contansts should be configurable later one. ILOG content
>> will be compressed later on so that it leaves minimum
>> footprint.
>
> List of <sha-1, pathname> tuples would not compress well, I suspect.

I was hoping that it still compresses well the discrete segments of
pathname. In the worst case we can group sha-1 together, separate from
pathnames.

>> Because it's only needed at index writing time, read-only
>> operations won't pay the cost for decompressing and compressing ILOG=
=2E
>
> Another idea is to lazily read existing ILOG by (1) keeping just an
> offset in the originating index file at read_index() time and (2)
> reading it on demand when ":-4:Makefile" was asked for.

We need to go through ILOG extension anyway for index sha-1
verification, so it's already read in kernel buffer. What we save is a
just malloc. But I'll try.

>
>> diff --git a/cache.h b/cache.h
>> index 85b544f..a2156bf 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -168,6 +168,7 @@ struct cache_entry {
>>
>>  /* used to temporarily mark paths matched by pathspecs */
>>  #define CE_MATCHED           (1 << 26)
>> +#define CE_BASE              (1 << 27)
>
> As this is not about pathspec match, please have its own comment
> line (or a blank line, if this goes without comment) above this new
> line.

This patch is more about the idea, whether it makes sense. You would
(and did) find the patch somewhat disgusting later on.

>> @@ -277,6 +278,7 @@ struct index_state {
>>                initialized : 1;
>>       struct hash_table name_hash;
>>       struct hash_table dir_hash;
>> +     struct strbuf *index_log;
>>  };
>
> Sane to have this as a per-index_state variable.
>
>> +extern void log_index_changes(const char *prefix, const char **argv=
);
>
> Not sane to name this function _index_anything and not to have index_=
state
> as its first parameter, breaking the naming convention.

The reason I can't put index_state there is because this function is
called early, often before read_cache is is called. And I can't caller
it later because argv would be ruined by parse_options(). An option is
to convert argv to a string unconditionally in git.c, then
log_index_changes can be called much later, and with index_state
pointer.

>> +static void get_updated_entries(struct index_state *istate,
>> +                             struct cache_entry ***cache_out,
>> +                             unsigned int *cache_nr_out)
>> +{
>> +     struct cache_entry **cache;
>> +     unsigned int i, nr, cache_nr =3D 0;
>> +
>> +     *cache_nr_out =3D 0;
>> +     *cache_out =3D NULL;
>> +     for (i =3D 0; i < istate->cache_nr; i++) {
>> +             if (istate->cache[i]->ce_flags & CE_BASE)
>> +                     continue;
>> +             cache_nr++;
>> +     }
>> +     if (!cache_nr)
>> +             return;
>> +     cache =3D xmalloc(cache_nr * sizeof(*istate->cache));
>> +     for (i =3D nr =3D 0; i < istate->cache_nr; i++) {
>> +             struct cache_entry *ce =3D istate->cache[i];
>> +             if (ce->ce_flags & CE_BASE)
>> +                     continue;
>> +             cache[nr++] =3D ce;
>> +     }
>> +     *cache_out =3D cache;
>> +     *cache_nr_out =3D cache_nr;
>> +}
>
> I can read what the function does, but I do not understand the
> assumption this code makes.
>
> Is this assuming that any newly created cache_entry that goes to
> the_index via add_index_entry() will not have CE_BASE bit set?  Some
> codepaths try to preserve the flags bit they do not care and/or
> understand (e.g. rename_index_entry_at() creates a new ce with a new
> name, and keeps most of the flags bit except for the name-hash state
> bits), so CE_BASE will be propagated from the original to the new
> one, I think.
>
> You seem to be recording the state _after_ the change---that can be
> read without the extension, can't it?  I thought we care more about
> the state that was _lost_ by the change.
>
> Recording the state after the change misses deleted entries, doesn't
> it?

Right. At the end of the commit message I mentioned about "git add
--undo". After I wrote it, I became more convinced it's the way to go.
That should be the UI, instead of letting the user hunt the right
entry through the index log. And then caller has the responsibility to
track changes and feed it to read-cache (CE_BASE trick is gone). And
it would record something like raw diff: a pair of old/new sha-1 and a
path name. This helps differentiate modified, deleted and added
entries that "git add --undo" may need to undo.

>> +static void write_index_log(struct strbuf *sb,
>> +                         const struct strbuf *old_log,
>> +                         const struct strbuf *msg,
>> +                         struct cache_entry **cache,
>> +                         unsigned int cache_nr)
>> +{
>> +     struct strbuf body =3D STRBUF_INIT;
>> +     unsigned int i, size, nr, body_len, hdr_len;
>> +     const char *end, *p;
>> +     strbuf_addf(&body, "%s%c", msg->buf, '\0');
>> +     for (i =3D 0; i < cache_nr; i++)
>> +             strbuf_addf(&body, "%s %s%c", sha1_to_hex(cache[i]->sh=
a1),
>> +                         cache[i]->name, '\0');
>
> We do not care about file modes (e.g. "update-index --chmod")?

Not as valuable in my opinion. But if I implement "git add --undo", I
probably need to pay attention to file modes or some users may get
upset as it's not a "real undo" otherwise.
--=20
Duy
