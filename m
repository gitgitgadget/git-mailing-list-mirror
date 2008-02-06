From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like
 write failures
Date: Wed, 06 Feb 2008 13:41:20 -0600
Message-ID: <47AA0D60.60504@nrlssc.navy.mil>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>	 <47A9E4F9.8050100@nrlssc.navy.mil> <e1dab3980802061059m5bf9c291s892da586248e229c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	David Steven Tweed <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqAc-0008Dn-4J
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805AbYBFTmB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758786AbYBFTmB
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:42:01 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47896 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758735AbYBFTl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:41:59 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m16JfKvD013586;
	Wed, 6 Feb 2008 13:41:21 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 6 Feb 2008 13:41:20 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <e1dab3980802061059m5bf9c291s892da586248e229c@mail.gmail.com>
X-OriginalArrivalTime: 06 Feb 2008 19:41:20.0932 (UTC) FILETIME=[3FA9A640:01C868F8]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15706001
X-TM-AS-Result: : Yes--11.283200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDYzOS03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDQyNTctNzA4NTU4LTcwODE3OS03?=
	=?us-ascii?B?MDIzNzYtNzA5NTg0LTcwMjM1OC0xMzk2MjktNzAxNDU1LTEwNTI1?=
	=?us-ascii?B?MC03MDA2OTMtNzAwNDc2LTcwOTA2NS03MDM3ODgtNzAxMjAyLTcw?=
	=?us-ascii?B?NjEwOS0xMTMyMjgtNzAwNjI0LTcwOTI1MS03MDI5MDEtNzAzNzMx?=
	=?us-ascii?B?LTE4ODAxOS0xODgxOTktNzAzMTc5LTcxMDc5OS0xNDgwMzktMTQ4?=
	=?us-ascii?B?MDUxLTIwMDQy?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72832>

David Tweed wrote:
> On Feb 6, 2008 4:48 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> I also suggest taking a look at the functions in builtin-prune-packed.c to see
>> how similar functions are implemented there.
>>
>> Use strlcpy instead of sprintf.
>> Use prefixcmp instead of strncmp.
>> Use same messages as prune_dir() for show_only path and unlink failure.
>> You could also check the opendir call and print a suitable message on failure.
> 
> All the other path creation in builtin-prune.c is using sprintf; is
> doing 3 strlcpy's much better? (I backed off from using snprintf when
> the other element in the if that tested it vanished; I probably ought
> to put that back.)

They use sprintf for the "%02x" part, but they use memcpy to copy the return
of get_object_directory() into a fixed string and then append onto that,
rather than repeatedly writing the same string over and over. Ok, there is one
instance in builtin-prune.c that repeatedly writes path, but builtin-prune-packed.c
does the memcpy thing.

Something like:

	char pathname[PATH_MAX];
	...

	/* check length of dirname not too long */

	memcpy(pathname, dirname, len);

	if (len && pathname[len-1] != '/')
		pathname[len++] = '/';

	...

	while ((de = readdir(dir)...) {
		if (!prefixcmp(...
			if (strlcpy(pathname + len, de->d_name, PATH_MAX - len)
			    >= PATH_MAX - len) {
				warning("too long path encountered: %s%s",
					pathname, de->d_name);
				continue;
			}

			...


-brandon
