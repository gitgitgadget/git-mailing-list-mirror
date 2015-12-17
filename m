From: Shawn Pearce <spearce@spearce.org>
Subject: RefTree: Alternate ref backend
Date: Thu, 17 Dec 2015 13:02:50 -0800
Message-ID: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 22:03:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9fhk-0002h8-5z
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 22:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbbLQVDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 16:03:12 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34000 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754936AbbLQVDL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 16:03:11 -0500
Received: by mail-vk0-f45.google.com with SMTP id j66so54064157vkg.1
        for <git@vger.kernel.org>; Thu, 17 Dec 2015 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=+iGWLxAS/GDeQHWv977MJW9+vEK72VjdIISOceqftBg=;
        b=acPPmTHO4axfLjZJLRbUdKln/bt/vaohLZe413oIlVyH7A5FRdRIEXc+c6qlJBYbdQ
         vmHlGkg0vIaXeq3lNQqY5vhf2zcQ1b1DRyIlX40uYgTj9c1YaeSjOViMp4pqKmuHjNUl
         a6oIadgXIJJEGVCrWhHZQaDRuGTUqIx7517a8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=+iGWLxAS/GDeQHWv977MJW9+vEK72VjdIISOceqftBg=;
        b=j5V/PofKgpnpf+qY3yaWNK97wpRZ6bq4rK3qPQvts5o74+HL5otoJicLyWojibkJQL
         1WuFNSejL+dXkMr85A384Mkt5AxDKlC6QSlDZSQFG085eBfoSbbd68DgwjxL0GhcVY57
         bYVsoHpkfbwdhl7DbudifxG59WB66EK5as9fRHMoL9jEj9p6ge6rhSsuXNe0JpxXXO+W
         /dvBZUrn51jyXeaeWbGj8yhK1wAG5MlZfzMUTOGmgwcbOBJqb8kGv/nkuWllzbnh9ceT
         IIcIsyFpoGKikQKOOYousNiHdKwfsVhdJB8TZj9edc4Uzos3LYfjqoeG/NHCBS8pIyMb
         x8PQ==
X-Gm-Message-State: ALoCoQlgiSR3nYeBIJmKU21pTFSzx0a/nBzN8EoiLf8ZwGws/RqMPIOHMarNCzThC/1sy/IUGmJwn74FOhiOoYcPacmQv+INUg==
X-Received: by 10.31.141.65 with SMTP id p62mr40229671vkd.93.1450386190022;
 Thu, 17 Dec 2015 13:03:10 -0800 (PST)
Received: by 10.103.97.197 with HTTP; Thu, 17 Dec 2015 13:02:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282677>

I started playing around with the idea of storing references directly
in Git. Exploiting the GITLINK tree entry, we can associate a name to
any SHA-1.

By storing all references in a single tree, atomic transactions are
possible. Its a simple compare-and-swap of a single 40 byte SHA-1.
This of course leads to a bootstrapping problem, where do we store the
40 byte SHA-1? For this example its just $GIT_DIR/refs/txn/committed
as a classical loose reference.


I posted code for this to JGit (sorry):

   https://git.eclipse.org/r/62970


Configuration:

  [core]
    repositoryformatversion = 1
  [extensions]
    refsBackendType = RefTree

For example, recent git.git has a structure like this:

  $ git ls-tree -r refs/txn/committed
  120000 blob 22e42fc826b437033ca444e09368f53a0b169322 ..HEAD
  160000 commit 1ff88560c8d22bcdb528a6629239d638f927cb96 heads/maint
  160000 commit f3adf457e046f92f039353762a78dcb3afb2cb13 heads/master
  160000 commit 5ee9e94ccfede68f0c386c497dd85c017efa22d6 heads/next
  160000 commit d3835d54cffb16c4362979a5be3ba9958eab4116 heads/pu
  160000 commit 68a0f56b615b61afdbd86be01a3ca63dca70edc0 heads/todo
  ...
  160000 commit 17f9f635c101aef03874e1de1d8d0322187494b3 tags/v2.6.0
  160000 commit 5bebb9057df8287684c763c59c67f25f16884ef6 tags/v2.6.0-rc0
  160000 commit 16ffa6443e279a9b3b63d7a2bebeb07833506010 tags/v2.6.0-rc0^{}
  160000 commit bbdca2a7bd942e1d3ce517b48e6229b99f7d7b2b tags/v2.6.0-rc1
  160000 commit 689efb737a7b46351850eefdfa57d2ce232011fb tags/v2.6.0-rc1^{}
  160000 commit 7b269a793392ee3d71ecddac88a8ad63497cbc4d tags/v2.6.0-rc2
  160000 commit 45733fa93f287fbc04d6a6a3f5a39cc852c5cf50 tags/v2.6.0-rc2^{}
  160000 commit 27df6e2585060add45b32bbd46f6e92ef79d069b tags/v2.6.0-rc3
  160000 commit 8d530c4d64ffcc853889f7b385f554d53db375ed tags/v2.6.0-rc3^{}
  160000 commit be08dee9738eaaa0423885ed189c2b6ad8368cf0 tags/v2.6.0^{}

Tags are stored twice, to cache the peel information for network advertisements.

Packing the tree by itself is smaller than packed-refs, which is uncompressed:

  -rw-r----- 1 shawn me  60K Dec 17 12:43 packed-refs
  -r--r----- 1 shawn me 1.2K Dec 17 12:56 R-5533*.idx
  -r--r----- 1 shawn me  28K Dec 17 12:56 R-5533*.pack


By exploiting Git to store Git, we get a reflog for free:

  $ git log -p refs/txn/committed -1
  commit f7ec5ceeba6ca87fa112b3af70d8ac17364045f7
  Author: anonymous <anonymous@localhost>
  Date:   Thu Dec 17 12:53:39 2015 -0800

      push

  diff --git a/heads/tmp2 b/heads/tmp2
  deleted file mode 160000
  index f3adf45..0000000
  --- a/heads/tmp2
  +++ /dev/null
  @@ -1 +0,0 @@
  -Subproject commit f3adf457e046f92f039353762a78dcb3afb2cb13

:)
