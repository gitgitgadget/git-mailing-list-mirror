From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v7 00/10] interactive git clean
Date: Wed,  8 May 2013 19:38:45 +0800
Message-ID: <cover.1368011946.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 08 13:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ua2iI-0000sV-9G
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 13:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111Ab3EHLjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 07:39:09 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:55217 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815Ab3EHLjI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 07:39:08 -0400
Received: by mail-pd0-f170.google.com with SMTP id 10so1182647pdi.15
        for <git@vger.kernel.org>; Wed, 08 May 2013 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=JHh1DHT9dOc7CLpsQOJj+LciOu3juMTxrLRCLIZDYuY=;
        b=DpN6KUkixgvNL9+2uuDsvyMXmzUUrzXfGWlC8hMSuueVyPYvrpk5CGPlwh4HHOrrjx
         saw3c3yYCYT+7xGNku/8TmlnelZ/2S75WCyyz30pTbupVk3wpvX7SP0Rhk3gYFCgW0/j
         jIqU5/54aBYvPFlksXtjhwrNAnqG7SF62p4ZiifAPzUmSLWzu5T5LLrggseh5dVlhl8o
         T2WiuKrLnC7855lj/zpriqI9VshLKATBegOHslnV15X1gORQ/iIBd0S0xQSthLa3gf/I
         CFY8fIQCcE7KbKI+DUwbbptxsrSc+jtjPDNrKXJz79Bqj0zwXLRbvM6k3clYkHdxJ5zk
         zkPQ==
X-Received: by 10.66.218.36 with SMTP id pd4mr7532232pac.143.1368013147301;
        Wed, 08 May 2013 04:39:07 -0700 (PDT)
Received: from localhost.localdomain ([114.246.128.169])
        by mx.google.com with ESMTPSA id gc5sm32287860pbb.19.2013.05.08.04.39.03
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 04:39:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.341.g1c24ab7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223657>

Significant updates since patch v6 series:

 * Refactor on patch 4/10: split `list_and_choose` into 3 functions,
   to make it easy to read.

 * Mark no public functions as static for patch 1-10.

 * If set 'pager.clean' to true (i.e. isatty(1) is false), die
   instead of do cleaning.

 * New action: flags. The user can update flags for git-clean,
   such as -x/-d/-X/-ff.

 * Alway show interactive menu, even there are no files to clean.
   Because the use can update flags for git-clean.
 
Usage:

When the command enters the interactive mode, it shows the
files and directories to be cleaned, and goes into its
interactive command loop.

The command loop shows the list of subcommands available, and
gives a prompt "What now> ".  In general, when the prompt ends
with a single '>', you can pick only one of the choices given
and type return, like this:

    *** Commands ***
      1: clean               2: edit by patterns    3: edit by numbers     4: rm -i
      5: flags: none         6: quit                7: help
    What now> 2

You also could say `c` or `clean` above as long as the choice is unique.

The main command loop has 7 subcommands.

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

flags::

  This lets you change the flags for git-clean, such as -x/-X/-d/-ff,
  and refresh the cleaning candidates list automatically.

quit::

  This lets you quit without do cleaning.

help::

  Show brief usage of interactive git-clean.


Jiang Xin (10):
  Add support for -i/--interactive to git-clean
  Show items of interactive git-clean in columns
  Add colors to interactive git-clean
  git-clean: use a git-add-interactive compatible UI
  git-clean: interactive cleaning by select numbers
  git-clean: rm -i style interactive cleaning
  git-clean: update document for interactive git-clean
  git-clean refactor: save some options in clean_flags
  git-clean refactor: wrap in scan_clean_candidates
  git-clean: change clean flags in interactive mode

 Documentation/config.txt    |   4 +
 Documentation/git-clean.txt |  76 +++-
 builtin/clean.c             | 972 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 981 insertions(+), 71 deletions(-)

-- 
1.8.3.rc1.341.g1c24ab7
