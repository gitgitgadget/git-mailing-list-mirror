From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH 2/3] Teach read_tree_recursive() how to traverse into 
	submodules
Date: Sun, 18 Jan 2009 17:37:39 +0100
Message-ID: <8c5c35580901180837i6e835d98ob8875ce1b8ad3011@mail.gmail.com>
References: <1232275999-14852-1-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-2-git-send-email-hjemli@gmail.com>
	 <1232275999-14852-3-git-send-email-hjemli@gmail.com>
	 <49735530.4090901@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Jan 18 17:39:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOafv-0001lX-6n
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 17:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758845AbZARQhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 11:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758277AbZARQhl
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 11:37:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:11444 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757155AbZARQhj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 11:37:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1291132wah.21
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aVZbz1BuGxnQtw9FBLOWlFLuIjyeafqggqwTuVYa1Bo=;
        b=PeThyOaBteqxPxI2/TYRC7OpIxlC2566f6Qg99qv2YA6kWpY9Fe0c/cz7Kq2AgEBqS
         eZYpXo3MMUn37fifuA6bRhOeR7WNsnCsbfYTaW7yeHtGnTJg7eQ+7icDnCqbIoMyvgY+
         yLiHNcoqHm+Z3fszILrj5e71c+HIFua5b4DT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vvkxxzoE/gw604Gcq1ZNKvaSi1r/aIHNhZ/b0fbMeg2BzCTYb97pB3pWJRTbSy1v8g
         kL4IZrwyn6HZ/2BuMN1HGT6xN4zI6ZTknnu/OXuSZQjI+cuYJPDWuDoSPaXygbEHeuHV
         aOZlMiCgH3x7kBz33QYdqolT2NqgKlB11fX2o=
Received: by 10.115.92.2 with SMTP id u2mr3353944wal.228.1232296659224; Sun, 
	18 Jan 2009 08:37:39 -0800 (PST)
In-Reply-To: <49735530.4090901@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106239>

On Sun, Jan 18, 2009 at 17:13, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.=
ath.cx> wrote:
> Lars Hjemli schrieb:
>> The traversal of submodules is only triggered if the current submodu=
le
>> HEAD commit object is accessible. To this end, read_tree_recursive()
>> will try to insert the submodule odb as an alternate odb but the lac=
k
>> of such an odb is not treated as an error since it is then assumed t=
hat
>> the user is not interested in the submodule content. However, if the
>> submodule odb is found it is treated as an error if the HEAD commit
>> object is missing.
>
> Callers of read_tree_recursive() specify a tree to traverse.
> Unconditionally using the HEAD of submodules feels a bit restrictive,
> but I don't use submodules, so I have no idea what I'm actually talki=
ng
> about here. :)

=46or bare repositories (where the submodule repo is added to
objects/info/alternates), following the tree of the linked commit is
the only option. And for non-bare repositories with the submodule
checked out, I think we should honor the users choice of checked out
HEAD in the submodule (especially since we don't have any other way to
specify which submodule commit to follow).


>
>>  int read_tree_recursive(struct tree *tree,
>>                       const char *base, int baselen,
>>                       int stage, const char **match,
>> @@ -132,6 +188,30 @@ int read_tree_recursive(struct tree *tree,
>>                               return -1;
>>                       continue;
>>               }
>> +             if (S_ISGITLINK(entry.mode) && get_traverse_gitlinks()=
) {
>> +                     int retval;
>> +                     char *newbase;
>> +                     struct tree *subtree;
>> +                     unsigned int pathlen =3D tree_entry_len(entry.=
path, entry.sha1);
>> +
>> +                     newbase =3D xmalloc(baselen + 1 + pathlen);
>> +                     memcpy(newbase, base, baselen);
>> +                     memcpy(newbase + baselen, entry.path, pathlen)=
;
>> +                     newbase[baselen + pathlen] =3D 0;
>> +                     if (!traverse_gitlink(newbase, entry.sha1, &su=
btree)) {
>> +                             free(newbase);
>> +                             continue;
>> +                     }
>> +                     newbase[baselen + pathlen] =3D '/';
>> +                     retval =3D read_tree_recursive(subtree,
>> +                                                  newbase,
>> +                                                  baselen + pathlen=
 + 1,
>> +                                                  stage, match, fn,=
 context);
>> +                     free(newbase);
>> +                     if (retval)
>> +                             return -1;
>> +                     continue;
>> +             }
>>       }
>>       return 0;
>>  }
>
> You don't need to call get_traverse_gitlinks() in the if statement ab=
ove
> if you make all read_tree_recursive() callback functions return 0 for
> gitlinks that they don't want to follow and READ_TREE_RECURSIVE for
> those they do.  It's cleaner without the static variable and its
> accessors and more flexible, too: the callbacks might decide to trave=
rse
> only certain submodules.

I like the idea, but it will require thorough review of all
read_tree_recursive() consumers. So now we've got three different
approaches:
* me: global setting
* dscho: parameter to read_tree_recursive()
* you: accept the return value from the callback function

Junio, what would you prefer?

--
larsh
