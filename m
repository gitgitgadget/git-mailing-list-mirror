Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1161FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 18:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdFSSJY convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Jun 2017 14:09:24 -0400
Received: from mail.plc2.de ([212.43.91.138]:56758 "EHLO mail.plc2.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdFSSJY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 14:09:24 -0400
Received: from SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb]) by
 SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb%10]) with mapi id
 14.01.0438.000; Mon, 19 Jun 2017 20:09:22 +0200
From:   Patrick Lehmann <Patrick.Lehmann@plc2.de>
To:     Stefan Beller <sbeller@google.com>
CC:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Subject: AW: Restoring detached HEADs after Git operations
Thread-Topic: Restoring detached HEADs after Git operations
Thread-Index: AdLo2JTYy82hS69wTnuiUW9EIL+4M///6qaAgAAkeNWAAFK+gIAAL/wm///jxgCAACeMAA==
Date:   Mon, 19 Jun 2017 18:09:21 +0000
Message-ID: <0092CDD27C5F9D418B0F3E9B5D05BE0801028B70@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
 <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE0801028A86@SBS2011.opfingen.plc2.de>,<CAGZ79kbMOdkKiVsvxk4UeKKPicyi958LpomeY=ypXT0_=5d8BQ@mail.gmail.com>
In-Reply-To: <CAGZ79kbMOdkKiVsvxk4UeKKPicyi958LpomeY=ypXT0_=5d8BQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.42.2.129]
x-g-data-mailsecurity-for-exchange-spamlevel: 0
x-g-data-mailsecurity-for-exchange-state: 0
x-g-data-mailsecurity-for-exchange-error: 0
x-g-data-mailsecurity-for-exchange-sender: 32
x-g-data-mailsecurity-for-exchange-server: 70cd0149-74d1-4df2-bc08-c934d48ac3c3
x-g-data-mailsecurity-for-exchange-guid: B876F998-50AD-46B2-B6EF-C490404D0673
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Stefan,

the use case is as follows:

The projects consists of circa 18 IP cores. Each IP core is represented by a Git repository. Think of an IP core as of a lonestanding DLL or SO file project. Each IP core references 2 submodules, which bring the verification environments for testing the IP core standalone.

These 18 IP cores are grouped to bigger IP cores, referencing the low-level IP cores and each again the 2 verification submodules. Finally, the main project references the bigger IP cores and again the 2 verification cores.

TOPLEVEL
  o- IP1
       o- UVVM
       o- VUnit
  o- IP2
       o- UVVM
       o- VUnit
  o- IP3
       o- UVVM
       o- VUnit
  o- IP4
       o- UVVM
       o- VUnit
       o- IP5
           o- UVVM
           o- VUnit
       o- IP6
           o- UVVM
           o- VUnit
       o- IP7
           o- UVVM
           o- VUnit
  o- IP8
       o- UVVM
       o- VUnit
       o- IP9
           o- UVVM
           o- VUnit
       o- IP10
           o- UVVM
           o- VUnit
  o- IP11
       o- UVVM
       o- VUnit
       o- IP9
           o- UVVM
           o- VUnit
       o- IP12
           o- UVVM
           o- VUnit
   o- UVVM
   o- VUnit

That's the simplified structure. I can't write more, because it's a closed source project. You can find other usecases e.g. in my other open source projects. E.g. The PoC-Library or The PicoBlaze-Library and the corresponding PoC-Examples repository.

Example: PoC
Pile of Cores includes 4 Git submodules and is itself an IP core library.
So PoC-Examples again references PoC. This looks like this tree:

PoC-Examples
  |- lib/
       o- PoC
            |- lib
                o- Cocotb
                o- OSVVM
                o- VUnit
                     o- .... OSVVM
                o- UVVM

The library VUnit itself already includes OSVVM as a library.

----------------------
Forcast:
I'll write a new question / idea about multiple equal submodules and the memory footprint soon...
Here is my original question posted on StackOverflow: https://stackoverflow.com/questions/44585425/how-to-reduce-the-memory-footprint-for-multiple-submodules-of-the-same-source
----------------------

Do you need more use cases?


Kind regards
    Patrick
________________________________________
Von: git-owner@vger.kernel.org [git-owner@vger.kernel.org]&quot; im Auftrag von &quot;Stefan Beller [sbeller@google.com]
Gesendet: Montag, 19. Juni 2017 19:47
Bis: Patrick Lehmann
Cc: Lars Schneider; Git Mailinglist
Betreff: Re: Restoring detached HEADs after Git operations

On Mon, Jun 19, 2017 at 10:34 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello,
>
> I'm just an advanced Git user, not a Git developer. So I might find some time to improve the suggested script, which I provided with the hints given on the mailing list, but I have no time to do a complete feature release in your patch based Git flow.

ok, thanks for letting us know. I may re-prioritize the "reattach
HEAD" patches that I referenced earlier.
I would have hoped that additionally to the shell lines you'd have
given a good use case/summary.

> I have no experience with other shells then Bash. So if you rely on a Bash with less features, please port the syntax to such a shell system. (I personally do not support legacy programs or out-date programs).
>
> ------
> We are talking about circa 50 submodules in total with a maximum depth of 4. The platforms are:
> - Mint OS with Git in Bash
> - Windows 7 with Git-Bash
> - Windows 10 with Git-Bash
> - Windows 10 with Posh-Git

Thanks,
Stefan
