From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache.c: Handle long filenames correctly
Date: Wed, 11 Jul 2012 18:34:21 +0700
Message-ID: <CACsJy8A880GeyTXy9jCa6vhD-ajL29qimf5Mf94eCVjAOb-TMg@mail.gmail.com>
References: <7vy5mtlebz.fsf@alter.siamese.dyndns.org> <1341998558-8502-1-git-send-email-t.gummerer@gmail.com>
 <1341998558-8502-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 13:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SovC9-00062N-Id
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 13:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842Ab2GKLez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 07:34:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45603 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab2GKLey (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 07:34:54 -0400
Received: by wibhr14 with SMTP id hr14so1029914wib.1
        for <git@vger.kernel.org>; Wed, 11 Jul 2012 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b07hAlWsKVwz3WEeysccy4JssqkcmbiVRa+NH2zSwCw=;
        b=a1/eeisK4qRGJ0FINGc81XdUppvR6bc0NKprtPmVUSUOlIODctZelawaR5rKGushXw
         9JZOIrvsktsQhp5oDSr1BUGB/V3n4pZ+UprzopSnYpiXyoIG5JtV0kF9fSpKqRhhCKa2
         eqnPJUDv/55tIl6EzIvE7zD26vINXvPF1QU7aTdsftiN3zUtXeW+V/at0MpPjegem6QA
         QSsRhBl2mSZoGlJCPE2U3ZdeVvSlkOOCI+IMIbr/TwSgScOwWE19jEYgxAd/DGRdGXbi
         UT0pOmedVxSEA/eQYuPg/3GOW38zMJjdRUC+N4D+M8FNuEsWo9M/PpaoDXIdjXSTpyv5
         nRbw==
Received: by 10.217.5.198 with SMTP id w48mr2736005wes.149.1342006492971; Wed,
 11 Jul 2012 04:34:52 -0700 (PDT)
Received: by 10.223.79.76 with HTTP; Wed, 11 Jul 2012 04:34:21 -0700 (PDT)
In-Reply-To: <1341998558-8502-2-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201294>

On Wed, Jul 11, 2012 at 4:22 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Make git handle long file/path names (> 4096 characters) correctly.
>
> There is a bug in the current version, which causes very long
> file/pathnames to be handled incorrectly, or not even added to
> the index, if they share the first 4096 characters.

The patch looks correct to me though we're stepping on the border
here. Linux's PATH_MAX is 4k and Git already has hard time dealing
with >=4k paths (even when a single path component is less than 4k).

> +       >path1 &&
> +       git update-index --add path1 &&
> +       (
> +               git ls-files -s path1 |
> +               sed -e "s/      .*/     /" |
> +               tr -d "\012"
> +               echo "$a"
> +       ) | git update-index --index-info &&
> +

or

BLOB=$(git hash-object -w -t blob --stdin </dev/null)
git update-index --cacheinfo 100644 $BLOB $a

I don't think git cares much in these tests and using empty tree sha-1
may even work (git recognizes that sha-1 automatically), but it may
hurt the reader..
-- 
Duy
