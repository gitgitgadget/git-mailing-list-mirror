Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D68C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 06:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhLQG2j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 01:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbhLQG2j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 01:28:39 -0500
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Dec 2021 22:28:38 PST
Received: from tsukuyomi.43-1.org (tsukuyomi.43-1.org [IPv6:2a01:4f8:c2c:1632::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A63DC061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 22:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=43-1.org;
 i=@43-1.org; q=dns/txt; s=2019; t=1639722061; h=from : to : subject :
 date : message-id : mime-version : content-type : from;
 bh=xWfHMiJyIVxwmbecEKv47ZcZfPEHfvj0twftj3yzKbQ=;
 b=P+AF7Vm7H98F08qlt0w6AYL7QBSdz3Q6RtULHt6kPIiIEHiTgg4j3IxrpTGzUGnKhnYQi
 /nVJDlPGXdxRFe8FgBSU+RdQR425cd7XMFo8RfgI1BW60aczMz3xLNdiTJKPLp5QLTVpteY
 1f4lxjG1HUUGAJpqM+N7W1NeD6ILR1yfG0aRtJxqWd2JaYGGOE646FdasdyzjjsCQnBTAKG
 N5Yy8QrmFi8ZVjBcfnBjiBB3QA26Ei/6GEYea6gsx6IdUXim1q2BRglk8+AaZgkTOeRBMeD
 s+4mfXyhmKNtYFOKlF94ZSwco+ghqPodaNYHz+IVbX66/yZTAeWzXT9WPWnQ==
From:   Matthias Maier <tamiko-GITVGER@43-1.org>
To:     git@vger.kernel.org
Subject: Using principal wildcards in gpg.ssh.allowedSignersFile
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Fri, 17 Dec 2021 00:20:59 -0600
Message-ID: <87zgoziwfo.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,

I am experimenting with git version 2.34.1 (and OpenSSH 8.8_p1) a bit
trying to set up a repository with SSH signatures for commits instead of
pgp. I have also tested the current "git next" branch.

The straight-forward setup (by having an "allowed_signers" file
naming individual e-mails and pubkeys) works as anticipated.

However, when trying to combine this with an SSH certificate authority
(which would be the use case I have in mind) I am not able to use an
e-mail wildcard in the "allowed_signers" file but have to specify full
e-mails instead. This, unfortunately, defeats a bit the purpose of
having an SSH certificate authority in the first place...

The corresponding low-level openssh facilities all seem to work
(including an e-mail wildcard in the ALLOWED SIGNERS file and
$ ssh-keygen -Y find-principals extracting the right e-mail).

I have attached full details how to reproduce below.

Can someone shed some light on this one?

Best,
Matthias



Steps to reproduce:

====================
Set up a minimal CA:
====================

  $ mkdir /tmp/signing-test
  $ cd /tmp/signing-test


A)  Set up two test pubkeys:

  $ ssh-keygen -t ed25519 -C "ca key" -f id_ca
  [...]
  $ ssh-keygen -t ed25519 -C "user key" -f id_user
  [...]


B)  Sign user key creating an SSH certificate:

  $ ssh-keygen -s id_ca -I "user key" -n "tamiko@43-1.org" id_user.pub
  Signed user key id_user-cert.pub: id "user key" serial 0 for tamiko@43-1.org valid forever

  $ ssh-keygen -L -f id_user-cert.pub
  id_user-cert.pub:
        Type: ssh-ed25519-cert-v01@openssh.com user certificate
        Public key: ED25519-CERT SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
        Signing CA: ED25519 SHA256:gix8Iux4j9Uf5fyTPdXbO/7EaLbpnhBczW3jw+2DHnw (using ssh-ed25519)
        Key ID: "user key"
        Principals:
                tamiko@43-1.org
  [...]


C)  Create allowed signers file:

  $ (printf '*@43-1.org cert-authority,namespaces="file,git" '; cat id_ca.pub) > allowed_signers

  ! Important: I used a wild card "*@43-1.org" for the principal!


D) Test setup:

  $ echo this is some random text > test.txt
  $ ssh-keygen -Y sign -f id_user-cert.pub -n file test.txt
  Signing file test.txt
  Write signature to test.txt.sig
  
  $ ssh-keygen -Y find-principals -f allowed_signers -n file -s test.txt.sig
  tamiko@43-1.org

  $ ssh-keygen -Y verify -f allowed_signers -I "tamiko@43-1.org" -n file -s test.txt.sig < test.txt
  Good "file" signature for tamiko@43-1.org with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
  

=======================
Set up a git repository
=======================

E) Set up an empty repository somewhere
  
  $ cd /tmp
  $ git init signing-test-repo
  $ cd signing-test-repo
  
  and modify .git/config to look like this:

        [core]
                repositoryformatversion = 0
                filemode = true
                bare = false
                logallrefupdates = true
        [commit]
                gpgsign = true
        [user]
                signingkey = /tmp/signing-test/id_user-cert.pub
        [gpg]
                format = ssh
        [gpg "ssh"]
                allowedSignersFile = /tmp/signing-test/allowed_signers


F) make a commit

  $ git commit -a --allow-empty -m "my shiny new ssh key signed commit"

  $ git log --show-signature
  Good "git" signature with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
  /tmp/signing-test/allowed_signers:1: no valid principals found
  No principal matched.
  Author: Matthias Maier <tamiko@43-1.org>
  Date:   Mon Dec 13 23:51:03 2021 -0600


G) modify allowd_signers entry to read "tamiko@43-1.org" instead of the wildcard "*@43-1.org":

  $ git log --show-signature
  Good "git" signature for tamiko@43-1.org with ED25519-CERT key SHA256:noSSfVeVlrYi6vGgK+jRPvyBnIV4ccVA0iW4IXYdXDQ
  Author: Matthias Maier <tamiko@43-1.org>
  Date:   Mon Dec 13 23:51:03 2021 -0600
