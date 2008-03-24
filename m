From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 14:02:37 -0500
Message-ID: <47E7FACD.7020409@nrlssc.navy.mil>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil> <47E298A5.6050508@nrlssc.navy.mil> <alpine.LSU.1.00.0803201812560.4124@racer.site> <7vr6e01xja.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:03:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrxP-0002AL-Ds
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 20:03:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759316AbYCXTDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 15:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759244AbYCXTDA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:03:00 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57683 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758552AbYCXTC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 15:02:59 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2OJ2bnZ030076;
	Mon, 24 Mar 2008 14:02:37 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Mar 2008 14:02:37 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vr6e01xja.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 24 Mar 2008 19:02:37.0338 (UTC) FILETIME=[A01B97A0:01C88DE1]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15806001
X-TM-AS-Result: : Yes--18.045400-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTgzMzUxOC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMzczMS03MDQ0MjEtNzA0NDI1LTcxMTYxMi03?=
	=?us-ascii?B?MDA0NzYtNzAzOTY5LTcwMzc4OC03MDA2MzAtNzAxMjIwLTcwMTIz?=
	=?us-ascii?B?Ni03MDUxMDItNzAwNjk1LTcwNTE3OC03MDE2MTktNzAwNzAxLTEz?=
	=?us-ascii?B?NjA3MC03MDIzNTgtMTg4MDE5LTcwNDkzNC03MDI3OTEtNzA0NDEw?=
	=?us-ascii?B?LTcwMTUwNi03MDA5NzEtNzAwNjI0LTEyMTYyNC03MDM3MjAtMTA1?=
	=?us-ascii?B?NjMwLTcwMDg0Ni03MDY0NTQtNzA4MjU3LTcwNzc1MC03MDYxNTAt?=
	=?us-ascii?B?NzAxOTE0LTcwNjExNC04MzQ2NjgtMTQ4MDM5LTE0ODA1MS0yMDA0?=
	=?us-ascii?B?Mg==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78079>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Thu, 20 Mar 2008, Brandon Casey wrote:
>>
>>> Add support for creating a new tag object and retaining the tag message, 
>>> author, and date when rewriting tags. The gpg signature, if one exists, 
>>> will be stripped.
>>>
>>> This adds nearly proper tag name filtering to filter-branch. Proper tag 
>>> name filtering would include the ability to change the tagger, tag date, 
>>> tag message, and _not_ strip a gpg signature if the tag did not change.
>> I think such a change in semantics merits a new option.
> 
> It is a different story if the fix is a good one, or has room for
> improvement.  For example, the sed script that knows what is on the first
> and second line and relies on that knowledge to use 1c...2c... looked very
> fragile to me.

This tag format is described in the documentation for git-mktag as follows:

   Tag Format
   ----------
   A tag signature file has a very simple fixed format: four lines of

     object <sha1>
     type <typename>
     tag <tagname>
     tagger <tagger>

   followed by some 'optional' free-form message (some tags created
   [...]

So, as long as git-cat-file succeeds, shouldn't we get this format piped
to sed? The type is hard coded to "commit", since $new_ref will always be
a commit (the old tag could have referenced another tag), otherwise the
earlier rev-parse would have failed.

The portion that strips the signature, does rely on the fact that git-tag
always adds the signature to the end of the tag object. Rather than
stripping only between the pgp BEGIN and END markers. And the 'Q' directive
may not be portable, but I really don't know.

Suggestions?

-brandon
