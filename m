From: David Barr <davidbarr@google.com>
Subject: Re: Bug in svn-fe: copying the root directory acts as if it's an
 empty directory
Date: Thu, 8 Mar 2012 11:46:14 +1100
Message-ID: <CAFfmPPOB5xq2zHeEL-cPw9HU7Kzm3NVNAoO+znr+Lk=vRyOvOw@mail.gmail.com>
References: <4F57EB82.4000309@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Mar 08 01:46:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5RUz-0005TT-9V
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 01:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006Ab2CHAqR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 19:46:17 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48539 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993Ab2CHAqP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 19:46:15 -0500
Received: by yhmm54 with SMTP id m54so3316485yhm.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 16:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=N+eAkCMk9txwNtGD2S/0l17xCwp13Ohqb0Wo6KqKf5c=;
        b=DcsKiZLPFlPso3oqc9QjYvSFa79+P9ZJOWWoJ2i88Xn7xaQe8c2HbIG0QzoCr3gkXm
         atOzTTvbVbA+TFz3MyidAcZ7uz1Rx4HD7Npfo2AEoFBKJhaC76v26p8oXWB/jqEXvnVf
         sYHmksVB9uqXqnrszDI1uPtkmwxmI+h02PPsxIuefkf4UHgx+FjwBRH9ToM9k3q2xbc5
         5fTYC71LuurwZzCd8foB+T80Wg655CW/CGFiS6dsmn4s13nsiuH6dxtOGI5GJgqdY2PY
         7dyZsuqvBdUp9fe+VfocVymt5LyzBzfwyzGrCQIe+yebWY7jNbpgHw6eCLcHDzbdyLyq
         jRNQ==
Received: by 10.60.25.65 with SMTP id a1mr2064930oeg.23.1331167575103;
        Wed, 07 Mar 2012 16:46:15 -0800 (PST)
Received: by 10.60.25.65 with SMTP id a1mr2064922oeg.23.1331167575008; Wed, 07
 Mar 2012 16:46:15 -0800 (PST)
Received: by 10.182.154.74 with HTTP; Wed, 7 Mar 2012 16:46:14 -0800 (PST)
In-Reply-To: <4F57EB82.4000309@pileofstuff.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQm87YCzb2+OC6mA3vo9rottlMnBYxbVZV8GDJzWB0E36uS/El84X3jWtrljOgSRFzq4cAsURdsNE6jW5Xs2fiOeYlEOJg40dvQ0FMykrKXEc87L8gz8+rwQ0siKrBWEnHwPFjbcu0IWurMCvPcNTcCC9JQSjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192510>

Hi Andrew,

On Thu, Mar 8, 2012 at 10:13 AM, Andrew Sayers
<andrew-git@pileofstuff.org> wrote:
> Here's a bug with svn-fe that I stumbled over while snorkelling throu=
gh
> repo madness. =A0I've tested it with the version of svn-fe in git.git=
's
> master branch.
>
> Copying the root directory to a sub-directory (e.g. doing `svn cp .
> trunk` to standardise your layout) doesn't correctly initialise the n=
ew
> directory.

This issue sounds very familiar, I wonder if there's an existing test
or pending patch for it? Maybe Dmitry or Jonathan can recall.

> To replicate the issue, run the following script from an
> empty directory (update GIT_DIR to point to your git.git repository):
>
> GIT_DIR=3D"/home/andrew/git/git"
> ROOT_DIR=3D"$(pwd)"
>
> svnadmin create repo
> svn checkout "file://$ROOT_DIR/repo" checkout
> cd checkout
> echo text > README.txt
> svn add README.txt
> svn ci -m "Created README.txt"
> svn cp "file://$ROOT_DIR/repo" "file://$ROOT_DIR/repo/trunk" \
> =A0 =A0-m "Created trunk"
> cd ..
> mkfifo backchannel
> mkdir git-repo
> cd git-repo/
> git init
> svnadmin dump --deltas "$ROOT_DIR/repo" \
> =A0 =A0| "$GIT_DIR/contrib/svn-fe/svn-fe" 3<../backchannel \
> =A0 =A0| "$GIT_DIR/git-fast-import" --cat-blob-fd=3D3 3>../backchanne=
l
>
> Expected: the git repo contains "README.txt" and "trunk/README.txt"
> Observed: "README.txt" exists but "trunk/README.txt" doesn't

Thanks for including a reproduction.

--
David Barr
