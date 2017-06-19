Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82D2920282
	for <e@80x24.org>; Mon, 19 Jun 2017 08:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbdFSIqs convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Jun 2017 04:46:48 -0400
Received: from mail.plc2.de ([212.43.91.138]:53687 "EHLO mail.plc2.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdFSIqr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 04:46:47 -0400
Received: from SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb]) by
 SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb%10]) with mapi id
 14.01.0438.000; Mon, 19 Jun 2017 10:46:46 +0200
From:   Patrick Lehmann <Patrick.Lehmann@plc2.de>
To:     Git Mailinglist <git@vger.kernel.org>
Subject: Restoring detached HEADs after Git operations
Thread-Topic: Restoring detached HEADs after Git operations
Thread-Index: AdLo2JTYy82hS69wTnuiUW9EIL+4Mw==
Date:   Mon, 19 Jun 2017 08:46:45 +0000
Message-ID: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.43.91.138]
x-g-data-mailsecurity-for-exchange-spamlevel: 0
x-g-data-mailsecurity-for-exchange-state: 0
x-g-data-mailsecurity-for-exchange-error: 0
x-g-data-mailsecurity-for-exchange-sender: 32
x-g-data-mailsecurity-for-exchange-server: 70cd0149-74d1-4df2-bc08-c934d48ac3c3
x-g-data-mailsecurity-for-exchange-guid: 2CB49E38-E34A-47EC-B231-42E6E3A8A6A3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I wrote a Bash script to recover branch names after Git operations have create detached HEADs in a Git repository containing lots of Git submodules. The script works recursively.

I would like to see:
a) that script or algorithm being integrated into Git by default
b) that as a default behavior for all Git operations creating detached HEADs

That's the command:
--------------------------------
git submodule foreach --recursive  'HEAD=$(git branch --list | head -n 1); if [[ "$HEAD" == *HEAD* ]]; then REF=$(git rev-parse HEAD); FOUND=0; for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); do if [[ "$(git rev-parse "$Branch")" == $REF ]]; then echo -e "  \e[36mCheckout $Branch...\e[0m"; git checkout $Branch; FOUND=1; break; fi done; if [[ $FOUND -eq 0 ]]; then echo -e "  \e[31mNo matching branch found.\e[0m"; fi else echo -e "  \e[36mNothing to do.\e[0m"; fi'
--------------------------------

How does it work:
1. It uses git submodule foreach to dive into each Git submodule and execute a series of Bash commands.
2. It's reading the list of branches and checks if the submodule is in detached mode. The first line contains the string HEAD.
3. Retrieve the hash of the detached HEAD
4. Iterate all local branches and get their hashes
5. Compare the branch hashes with the detached HEAD's hash. If it matches do a checkout.
6. Report if no branch name was found or if a HEAD was not in detached mode.

The Bash code with line breaks and indentation:
--------------------------------
HEAD=$(git branch --list | head -n 1)
if [[ "$HEAD" == *HEAD* ]]; then
  REF=$(git rev-parse HEAD)
  FOUND=0
  for Branch in $(git branch --list | grep "^  " | sed -e "s/  //" ); do
    if [[ "$(git rev-parse "$Branch")" == $REF ]]; then
      echo -e "  \e[36mCheckout $Branch...\e[0m"
      git checkout $Branch
      FOUND=1
      break
    fi
  done
  if [[ $FOUND -eq 0 ]]; then
    echo -e "  \e[31mNo matching branch found.\e[0m"
  fi
else
  echo -e "  \e[36mNothing to do.\e[0m"
fi
--------------------------------

Are their any chances to get it integrated into Git?

I tried to register that code as a Git alias, but git config complains about quote problem not showing where. It neither specifies if it's a single or double quote problem. Any advice on how to register that piece of code as an alias?

If wished, I think I could expand the script to also recover hash values to Git tags if no branch was found.

Kind regards
    Patrick Lehmann
