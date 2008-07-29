From: Paul Gideon Dann <pdgiddie@googlemail.com>
Subject: git-attic
Date: Tue, 29 Jul 2008 12:57:38 +0100
Message-ID: <488F05B2.6060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNnql-0006Hl-Sv
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 13:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbYG2L5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 07:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756186AbYG2L5o
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 07:57:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:28714 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920AbYG2L5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 07:57:42 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1655400nfc.21
        for <git@vger.kernel.org>; Tue, 29 Jul 2008 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=E19M8cFRmHaIQBgDWa2E7FEoYJnsRF1GJnr0KNzm5g4=;
        b=AarXTa3izegtpZ5oq8+G0XO5B/niKs2n5L4+CUnU+3QtSYmAksprWRT4GgQWekx4/8
         slETP6Pkiujd9cXMza+azKoop4j4Z7dDR5tnpsI/1pODNSc4ztIxbgZYRAGy2uyWaHo+
         0YfhUuLgCeoNvJsUphvC9bzweoJ8mjFWVrkBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=At73tCRmf139Fl/HUm6ZZURyA3+vN2mMhwkA7d+SVbDEwULefOJJy6LAIxXOSKxlIP
         n9MjdC2eKvZEmeg1RPpafAM0yqHQYEHqJuwt35oK3Zjz+dO/uu7177yX8F+CPavf9sb4
         IT4ul6+lp0Xs8j9FKtZMIPUARaYUzslV70iCQ=
Received: by 10.210.49.19 with SMTP id w19mr7522824ebw.11.1217332660575;
        Tue, 29 Jul 2008 04:57:40 -0700 (PDT)
Received: from Lemmie.local ( [82.46.201.97])
        by mx.google.com with ESMTPS id g9sm2194448gvc.0.2008.07.29.04.57.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Jul 2008 04:57:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90620>

Hello all,

I looked around everywhere for a script that could make it easy for me 
to store stale branches in refs/attic for possible later retrieval.  I 
don't like such branches lying around in refs/heads and used to tag them 
to clear them out of the way, but then that makes "git push origin 
--tags" unusable, since I don't want to push my stale branches out...

Anyway, I wrote my own little script in the end and thought it might be 
useful to others.

Please Cc pdgiddie@gmail.com in replies,
Paul Gideon Dann


Usage: git-attic
       git-attic store <ref> [<commit>]
       git-attic remove <ref>


#!/bin/bash
###
# Original Author: Paul Gideon Dann <pdgiddie@gmail.com>
###

showUsage() {
  echo "Usage: git-attic"
  echo "       git-attic store <ref> [<commit>]"
  echo "       git-attic remove <ref>"
}

case $1 in
  "store")
    if [[ ! $2 ]]; then
      showUsage
      exit 1
    fi
    if [[ $3 ]]; then
      OBJECT_SHA1=`git-rev-parse --revs-only $3`
      if [[ ! $OBJECT_SHA1 ]]; then
        echo "$3 is not a recognisable commit object."
        exit 1
      fi
    else
      OBJECT_SHA1=`git show-ref -h HEAD | awk '{print $1}'`
    fi
    git update-ref refs/attic/$2 $OBJECT_SHA1
    echo "$2 stored in attic."
    ;;

  "remove")
    if [[ ! $2 ]]; then
      showUsage
      exit 1
    fi
    OBJECT_SHA1=`git show-ref attic/$2 | awk '{print $1}'`
    if [[ ! $OBJECT_SHA1 ]]; then
      echo "$2 does not exist in the attic!"
      exit 1
    fi
    git update-ref -d refs/attic/$2 $OBJECT_SHA1
    echo "$2 removed from attic."
    ;;

  *)
    if [[ $1 ]]; then
      showUsage
    else
      # display contents of attic
      git for-each-ref --format="%(refname)" refs/attic | awk -F / 
'{print $3}'
    fi
    ;;
esac
