From: Scott Chacon <schacon@gmail.com>
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 17:19:15 -0700
Message-ID: <d411cc4a0903191719j1a413d92n9fd8b8f4ee895180@mail.gmail.com>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
	 <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
	 <d411cc4a0903191618x503db946n62d3132eece69175@mail.gmail.com>
	 <7vzlfh5b7y.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0903191650160.16753@asgard.lang.hm>
	 <7vtz5p59zp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: david@lang.hm, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSTg-00050A-3U
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443AbZCTATT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 20:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbZCTATS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:19:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:24343 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbZCTATR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 20:19:17 -0400
Received: by rv-out-0506.google.com with SMTP id f9so814081rvb.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 17:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QlsFyYMx2sCZ6RIkIJ+ELtaMIy72utQo5aGDOT3rmTs=;
        b=kMR+T0Db5PpWU8QK5HGbj7KrAnFSdbA/tLynbMc78WhE5jvia1G5mxQ1//EUaneOVj
         jd1hB6c1nnUFvqrZkSI+4Rqa0PdG1MNzQt9fqo02Knxez0cDAkSqe62e9wQCgblOgNe6
         u9K/G6VGIPUt4nknhMlLpTvkK5InDCeedrzmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ouZuc7Xwzgh9jaVVNescVr+zVJXv+zQQyV7NBcgIxwq0EpHF1tAobd33m28rnHQOsm
         jdLfyVn0XqQGrihfs7ZuVl5Pq8Ww0zf9SuITdFsigvc3QFSSL7Tsf4wq+7dvVjByg4HD
         Qkrq/G4njQlmN1accPypzKtiCjpxxVRRUPCwA=
Received: by 10.141.170.10 with SMTP id x10mr1030653rvo.56.1237508355893; Thu, 
	19 Mar 2009 17:19:15 -0700 (PDT)
In-Reply-To: <7vtz5p59zp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113871>

Hey,

On Thu, Mar 19, 2009 at 5:11 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> david@lang.hm writes:
>
>> On Thu, 19 Mar 2009, Junio C Hamano wrote:
>>
>>> Scott Chacon <schacon@gmail.com> writes:
>>>
>>>> The point is that we don't keep this data as 'blob's - we don't tr=
y to
>>>> compress them or add the header to them, they're too big and alrea=
dy
>>>> compressed, it's a waste of time and often outside the memory
>>>> tolerance of many systems. We keep only the stub in our db and str=
eam
>>>> the large media content directly to and from disk. =C2=A0If we do =
a
>>>> 'checkout' or something that would switch it out, we could store t=
he
>>>> data in '.git/media' or the equivalent until it's uploaded elsewhe=
re.
>>>
>>> Aha, that sounds like you can just maintain a set of out-of-tree sy=
mbolic
>>> links that you keep track of, and let other people (e.g. rsync) dea=
l with
>>> the complexity of managing that side of the world.
>>>
>>> And I think you can start experimenting it without any change to th=
e core
>>> datastructures. =C2=A0In your single-page web site in which its sol=
e html file
>>> embeds an mpeg movie, you keep track of these two things in git:
>>>
>>> =C2=A0 =C2=A0 =C2=A0porn-of-the-day.html
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0porn-of-the-day.mpg -> ../media/6066f5ae=
75ec.mpg
>>>
>>> and any time you want to feed a new movie, you update the symlink t=
o a
>>> different one that lives outside the source-controlled tree, while
>>> arranging the link target to be updated out-of-band.

It seems like the main problem here would be that most operations in
the working directory would be overwriting not the symlink but the
file it points to.  If you do a simple 'cp ~/generated_file.mpg
porn-of-the-day.mpg' (to upload your newest and bestest porn), it will
overwrite the '../media/6066f5ae75ec.mpg' file, not the symlink so
that we can generate a new symlink.  Then if we haven't uploaded the
'../media/6066f5ae75ec.mpg' file anywhere yet, it's a goner.  Right?
What you are proposing is almost exactly what I want to do, but I'm
concerned with this issue of the symlink reference not working right
for normal working directory operations.  If a file is never
overwritten, however, this is basically identical to what I wanted to
do.

Scott


>>
>> that would work, but the proposed change has some advantages
>>
>> 1. you store the sha1 of the real mpg in the 'large file' blob so yo=
u
>> can detect problems
>
> You store the unique identifier of the real mpg in the symbolic link
> target which is a blob payload, so you can detect problems already. =C2=
=A0I
> deliberately said "unique identifier"; you seem to think saying SHA-1
> brings something magical but I do not think it needs to be even blob'=
s
> SHA-1. =C2=A0Hashing that much data costs.
>
> In any case, you can have a script (or client-side hook) that does:
>
> =C2=A0 =C2=A0(1) find the out-of-tree symlinks in the index (or in th=
e work tree);
>
> =C2=A0 =C2=A0(2) if it is dangling, and if you have definition of whe=
re to get that
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hierarchy from (e.g ../media), run rsync o=
r wget or whatever
> =C2=A0 =C2=A0 =C2=A0 =C2=A0external means to grab it.
>
> and call it after "git pull" updates from some other place. =C2=A0The=
 "git
> media" of Scott's message could be an alias to such a command.
>
> Adding a new type "external-blob" would be an unwelcome pain. =C2=A0R=
eusing
> "blob" so that existing "blob" codepath now needs to notice special "=
0"
> that is not length "0" is even bigger pain than that.
>
> And that is a pain for unknown benefit, especially when you can start
> experimenting without any changes to the existing data structure. =C2=
=A0In the
> worst case, the experiment may not pan out as well as you hoped and i=
f
> that is the end of the story, so be it. =C2=A0It is not a great loss.=
 =C2=A0If it
> works well enough and we can have the external large media support wi=
thout
> any changes to the data structure, that would be really great. =C2=A0=
If it
> sort-of works but hits limitation, we can analyze how best to overcom=
e
> that limitation, and at that time it _might_ turn out to be the best
> approach to introduce a new blob type.
>
> But I do not think we know that yet.
>
> In the longer run, as you speculated in your message, I think the nat=
ive
> blob codepaths need to be updated to tolerate a large, unmappable obj=
ects
> better. =C2=A0With that goal in mind, I think it is a huge mistake to
> prematurely introduce an arbitrary distinct "blob" and "large blob" t=
ypes,
> if in the end they need to be merged back again; it would force the f=
uture
> code indefinitely to care about the historical "large blob" types tha=
t was
> once supported.
>
>> 2. since it knows the sha1 of the real file, it can auto-create the
>> real file as needed, without wasting space on too many copies of it.
>
> Hmm, since when SHA-1 is reversible?
>
