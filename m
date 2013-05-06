From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v6 0/7] interactive git clean
Date: Tue,  7 May 2013 03:18:49 +0800
Message-ID: <cover.1367867498.git.worldhello.net@gmail.com>
References: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 06 21:19:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQwS-0001t4-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755488Ab3EFTTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:19:16 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:54125 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3EFTTP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:19:15 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so2204596pab.17
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XN1mivQluqfA38OkhgXN4GCEIL6LpcmmggiTN9sYMFc=;
        b=wb5U3yOYqd7MBAbli2OpuYN7gcPa2gcNyK2wBwPq6eKsSV2dtH1OH4QeMJltb94ZIs
         Re6zYgq+jT0k4nMyvyXBaFMnbOwn7kQOfSJXt+co2o9P7yZVj3fyrB7+4EBWmgFwh90F
         qvpjedrpibSp2kmo1t/0Nyf5wO72dsx+JmxcRf4omo9+f3KqrwtQ5iR3WZT1uuJUEWZT
         qsnAei49c/YiAU9zLWw7xSgVrbXfJXZL3ZA1kTRvgDAznXOam/ZFNx/7SSU66+zH7FCB
         ANQsKEziOd0UJNRrq75a9QrTnmDPBFq3quJWziuBakxDyd78MgkxITN6F68HA9VQrQHe
         r8AA==
X-Received: by 10.68.223.10 with SMTP id qq10mr9361324pbc.57.1367867955314;
        Mon, 06 May 2013 12:19:15 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id z8sm24951256pbt.23.2013.05.06.12.19.11
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 12:19:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.338.gb35aa5d
In-Reply-To: <CANYiYbG5q7g-Gn-EGtsgS4XYLbQJuY6Pr_6FgKknADTD5_KoTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223490>

Implement a 'git add --interactive' style of interactive git-clean.
It will show what would be done before start to clean.  See
``Interactive mode`` for details.

Interactive mode
----------------
When the command enters the interactive mode, it shows the
files and directories to be cleaned, and goes into its
interactive command loop.

The command loop shows the list of subcommands available, and
gives a prompt "What now> ".  In general, when the prompt ends
with a single '>', you can pick only one of the choices given
and type return, like this:

------------
    *** Commands ***
      1: clean             2: edit by patterns   3: edit by numbers
      4. rm -i             5. quit               6. help
    What now> 2
------------

You also could say `c` or `clean` above as long as the choice is unique.

The main command loop has 6 subcommands.

clean::

   Start cleaning files and directories, and then quit.

edit by patterns::

   This shows the files and directories to be deleted and issues an
   "Input ignore patterns>>" prompt. You can input a space-seperated
   patterns to exclude files and directories from deletion.
   E.g. "*.c *.h" will excludes files end with ".c" and ".h" from
   deletion. When you are satisfied with the filtered result, press
   ENTER (empty) back to the main menu.

edit by numbers::

   This shows the files and directories to be deleted and issues an
   "Select items to delete>>" prompt. When the prompt ends with double
   '>>' like this, you can make more than one selection, concatenated
   with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
   to choose 2,3,4,5,7,9 from the list.  If the second number in a
   range is omitted, all remaining patches are taken.  E.g. "7-" to
   choose 7,8,9 from the list.  You can say '*' to choose everything.
   Also when you are satisfied with the filtered result, press ENTER
   (empty) back to the main menu.

rm -i::

  This will show a "rm -i" style cleaning, that you must confirm one
  by one in order to delete items. This action is not as efficient
  as the above two actions.

quit::

  This lets you quit without do cleaning.

help::

  Show brief usage of interactive git-clean.



Jiang Xin (7):
  Add support for -i/--interactive to git-clean
  Show items of interactive git-clean in columns
  Add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: interactive cleaning by select numbers
  git-clean: rm -i style interactive cleaning
  git-clean: update document for interactive git-clean

 Documentation/config.txt    |   4 +
 Documentation/git-clean.txt |  71 ++++-
 builtin/clean.c             | 700 ++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 752 insertions(+), 23 deletions(-)

-- 
1.8.3.rc1.338.gb35aa5d
