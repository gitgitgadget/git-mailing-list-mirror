From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: Re: 'git grep needle rev' attempts to access 'rev:.../.gitattributes' in the worktree
Date: Wed, 10 Oct 2012 18:34:51 +0700
Message-ID: <1349868894-3579-1-git-send-email-pclouds@gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 13:35:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLuZf-00061H-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 13:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332Ab2JJLf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 07:35:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34396 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2JJLf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 07:35:28 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so616254pbb.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 04:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SJyRWNN+7PraTaIa1v04tRjTpQqDURquDoJBEuJrbK0=;
        b=gkSd6MC5PFpvr4Elf9q3pSkhaIMQ904fSEzyiIBH+cnmZV93m8gwegXUWG9Bu4GlGz
         pBuYoH3k3EqDuqVphW/l/k4ZUNA8JCQjK/o0g+OOxm2lVscf5pinewQjQENsatfCkspJ
         gj+hchNk8HGapGiWycshSOxVmdZgrngJKxp8nFfNPkDB7XU3juHaOiZvGoe3jPb/Kq4I
         Zec6G8VkBKd3k9vBSwro1p+7706kEekvgCk0isBofFRZoq5rPdiseRAsCAg7XZKRttLj
         7T9sjP/Iyk72OkG2WPJ4gX0dozG3lakRbs3oAvVzk9FQ0yVOjeZsr8uBNZslikYy4MVx
         lZZA==
Received: by 10.68.225.5 with SMTP id rg5mr72246153pbc.73.1349868927723;
        Wed, 10 Oct 2012 04:35:27 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id w4sm733348pav.27.2012.10.10.04.35.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Oct 2012 04:35:26 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 10 Oct 2012 18:35:18 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207400>

On Wed, Oct 10, 2012 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> I think we just need to have callers of grep_source_init provide us =
with
>> the actual pathname (or NULL, in the case of GREP_SOURCE_BUF). That =
is
>> where the information is lost.
>
> Yes.  I agree that is the right approach.

Here we go. No additional tests as I don't know how to write them. But
strace shows it's ok.

Currently we don't have many options to optimize attr access. We
cannot prepare a attr stack in advance for a specific directory, then
check attributes many times using the stack. We cannot prepare attr
stack from a tree object. As a result a normal "grep pattern --"
results in a lot of duplicate failed open(".../.gitattributes") calls.

Jeff King (1):
  grep: pass true path name to grep machinery

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  quote: let caller reset buffer for quote_path_relative()
  grep: stop looking at random places for .gitattributes

 Documentation/git-grep.txt |  7 +++++--
 builtin/clean.c            |  2 ++
 builtin/grep.c             | 19 ++++++++++++-------
 builtin/ls-files.c         |  1 +
 grep.c                     | 11 ++++++++---
 grep.h                     |  4 +++-
 quote.c                    |  1 -
 wt-status.c                |  1 +
 8 files changed, 32 insertions(+), 14 deletions(-)

--=20
1.7.12.1.406.g6ab07c4
