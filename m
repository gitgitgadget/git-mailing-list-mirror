From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 10 Feb 2012 14:12:47 +0700
Message-ID: <CACsJy8DQNHm8sTgxKL=+Ui5OBsJBpvPn+dRmN9bVMwq4TfNuxQ@mail.gmail.com>
References: <CACsJy8AxOZQ7S42V1g-b0vdBxPpjhFZe6qDkGaALnxQ6LiUssw@mail.gmail.com>
 <CB599BA0.42A6B%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 08:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvkfi-0003Pj-Nk
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 08:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab2BJHNU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 02:13:20 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53385 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab2BJHNT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 02:13:19 -0500
Received: by wics10 with SMTP id s10so1780759wic.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 23:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=m8zvMVoen26ikNbL+XTj3MDmE1ongYDKfn3MCgfpGS4=;
        b=Z2vdzE71+JzGCfRfTFw3CccRpzb1Sp2DZzhwvWSFi0QLA2djCaYSkZkA9qh638LhHj
         KZkmrm25lQqwWUboNY8BZ3H4odp+eI/TRHI9oOY0FA+LkEW4p9CngOelOlhBgdQ3g51k
         /P3P7J07ii6oCWS5n9CyGpBcHqzLugx/VhW0c=
Received: by 10.216.136.211 with SMTP id w61mr1865224wei.18.1328857998242;
 Thu, 09 Feb 2012 23:13:18 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Thu, 9 Feb 2012 23:12:47 -0800 (PST)
In-Reply-To: <CB599BA0.42A6B%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190385>

On Fri, Feb 10, 2012 at 4:06 AM, Joshua Redstone <joshua.redstone@fb.co=
m> wrote:
> Hi Nguyen,
> I like the notion of using --assume-unchanged to cut down the set of
> things that git considers may have changed.
> It seems to me that there may still be situations that require operat=
ions
> on the order of the # of files in the repo and hence may still be slo=
w.
> Following is a list of potential candidates that occur to me.
>
> 1. Switching branches, especially if you switch to an old branch.
> Sometimes I've seen branch switching taking a long time for what I th=
ought
> was close to where HEAD was.
>
> 2. Interactive rebase in which you reorder a few commits close to the=
 tip
> of the branch (I observed this taking a long time, but haven't profil=
ed it
> yet). =C2=A0I include here other types of cherry-picking of commits.
>
> 3. Any working directory operations that fail part-way through and ma=
ke
> you want to do a 'git reset --hard' or at least a full 'git-status'. =
=C2=A0That
> is, when you have reason to believe that files with 'assume-unchange'=
 may
> have accidentally changed.

All these involve unpack_trees(), which is full tree operation. The
bigger your worktree is, the slower it is. Another good reason to
split unrelated parts into separate repositories.


> 4. Operations that require rewriting the index - I think git-add is o=
ne?
>
> If the working-tree representation is the full set of all files
> materialized on disk and it's the same as the representation of files
> changed, then I'm not sure how to avoid some of these without playing=
 file
> system games or using wrapper scripts.
>
> What do you (or others) think?
>
>
> Josh
>
>
> On 2/7/12 8:43 AM, "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:
>
>>On Mon, Feb 6, 2012 at 10:40 PM, Joey Hess <joey@kitenet.net> wrote:
>>>> Someone on HN suggested making assume-unchanged files read-only to
>>>> avoid 90% accidentally changing a file without telling git. When
>>>> assume-unchanged bit is cleared, the file is made read-write again=
=2E
>>>
>>> That made me think about using assume-unchanged with git-annex sinc=
e it
>>> already has read-only files.
>>>
>>> But, here's what seems a misfeature...
>>
>>because, well.. assume-unchanged was designed to avoid stat() and
>>nothing else. We are basing a new feature on top of it.
>>
>>> If an assume-unstaged file has
>>> modifications and I git add it, nothing happens. To stage a change,=
 I
>>> have to explicitly git update-index --no-assume-unchanged and only =
then
>>> git add, and then I need to remember to reset the assume-unstaged b=
it
>>> when I'm done working on that file for now. Compare with running gi=
t mv
>>> on the same file, which does stage the move despite assume-unstaged=
=2E (So
>>> does git rm.)
>>
>>This is normal in the lock-based "checkout/edit/checkin" model. mv/rm
>>operates on directory content, which is not "locked - no edit allowed=
"
>>(in our case --assume-unchanged) in git. But lock-based model does no=
t
>>map really well to git anyway. It does not have the index (which may
>>make things more complicated). Also at index level, git does not
>>really understand directories.
>>
>>I think we could add a protection layer to index, where any changes
>>(including removal) to an index entry are only allowed if the entry i=
s
>>"unlocked" (i.e no assume-unchanged bit). Locked entries are read-onl=
y
>>and have assume-unchanged bit set. "git (un)lock" are introduced as
>>new UI. Does that make assume-unchanged friendlier?
>>--
>>Duy
>>--
>>To unsubscribe from this list: send the line "unsubscribe git" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20
Duy
