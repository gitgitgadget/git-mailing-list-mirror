From: "Ch'Gans" <chgans@gna.org>
Subject: Strange diff-index output
Date: Tue, 3 Nov 2015 12:59:37 +1300
Message-ID: <CABxGUTj-5vdmyVGkKuoMdBAG2EAQvLJNYLLA++T2hNFvGRmb0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 01:00:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtP1K-0001Ft-Cu
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 01:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbbKBX7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2015 18:59:39 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33824 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbKBX7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2015 18:59:38 -0500
Received: by qkcn129 with SMTP id n129so184943qkc.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 15:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=jyn95WKA89wZOJNQ3Si6hUpHlp7702TS/vE9+u6MATU=;
        b=n8el3+AsEF48swHifWsAZDA/Sg6FvxU7aeXxdv/+ALfr3kljY/JabWXngClwu8UoOs
         CJRWqXHM9b4Woz78o0Vuy/t5QGB4rzUV4Xc4A2EvSMcwYiMaZWvRL1Q2H5L2dUuZpgKO
         clti3AKX2oF7AdLA/Bea3FnMHMxEm/JlwlCzxPgsd+sNbuY/cHj1IYT9YdCI6zZxqd3h
         MbesDEtDt4WwhRPU406EvZ4EiKkBJELTYmS1t4QHbPOk/txoxLRruT6GUG8oJiyjdbjA
         HIA3nUoUQvPGLwwLrh+LERK9QO6Of0LMnhC3j2nzEGGff7GRkYUUg4ZSelDqIdgSLeSA
         +k0Q==
X-Received: by 10.55.71.81 with SMTP id u78mr33522627qka.81.1446508777859;
 Mon, 02 Nov 2015 15:59:37 -0800 (PST)
Received: by 10.140.107.70 with HTTP; Mon, 2 Nov 2015 15:59:37 -0800 (PST)
X-Google-Sender-Auth: OWFLMeV9wWyTLDQ53Ol03vH_BpY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280738>

Hi there,

We're using a script to verify that what we are building is clean
against our git repository, for this we're using "git rev-parse
--short HEAD" to get the current hash and "git diff-index --quiet
HEAD" to check for local modification.
This script works fine on developer's machines, but doesn't on our CI
system (Atlassian Bamboo/Stash).

HEAD points to refs/heads/FIX-XYZ and refs/heads/FIX-XYZ exists.

On our CI, the output of diff-index gives something like:
:100644 100644 abcdef 000000 M file1

Our problem is very likely related with how Bamboo works and/or how we
use it, but to investigate this issue further, I first would like to
understand the meaning of the above output.

>From the man page of diff-index:
- 100644 is the mode of "src"
- 100644 is the mode of dst
- abcdef is the hash of src
- 000000 is the hash of dst
- M stands for "Modified"
- file1 is the filename being considered.

>From my understanding, src here means the file system and dst the git
object. So the above should mean "file1" is new and out of sync with
the index, which doesn't make sense since "file1" is definitely in the
repository. The weird stuff is that diff-index report the same problem
on every single file no just a few!

Notes:
 - Something I've noticed with Bamboo is that the cloned repository
doesn't have any remotes. Although I'm not sure if it is relevant
here.
 - I have tried with "shallow copy" Bamboo option enabled or not and I
get the same problems
 - I have tried "git update-index", but still get the same results
 - git log still gives me the full log history (but no remote heads)
 - git status reports nothing else than a couple of generated files
 - git status HEAD reports that the working directory is clean
 - git diff-index --cached reports nothing

Does any of you have ever come across this kind of problem? Could
anyone shed some light on what's going on with our clone? Any
documentation point out or hints appreciated.

Thanks,
Chris
