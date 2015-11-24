From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH] merge-file: consider core.crlf when writing merge markers
Date: Tue, 24 Nov 2015 23:50:30 +0100
Message-ID: <5654E9B6.3090801@drbeat.li>
References: <1448314332-15581-1-git-send-email-dev+git@drbeat.li>
 <alpine.DEB.1.00.1511240844380.1686@s15462909.onlinehome-server.info>
 <5654E7FD.2060000@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:51:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1MQm-0002XV-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 24 Nov 2015 23:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbbKXWvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 17:51:23 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:60658 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932101AbbKXWvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 17:51:19 -0500
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id A693FC3445;
	Tue, 24 Nov 2015 23:51:17 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 7C88BC343D;
	Tue, 24 Nov 2015 23:51:17 +0100 (CET)
Openpgp: id=49D5794AEA77F907764FD89E304B93CF506A903A;
 url=http://drbeat.li/pubkey.asc
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <5654E7FD.2060000@drbeat.li>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281645>

On 24.11.15 23:43, Beat Bolli wrote:
> On 24.11.15 09:21, Johannes Schindelin wrote:
>> Hi Beat,
>>
>> On Mon, 23 Nov 2015, Beat Bolli wrote:
>>
>>> When merging files in repos with core.eol = crlf, git merge-file inserts
>>> just a LF at the end of the merge markers. Files with mixed line endings
>>> cause trouble in Windows editors and e.g. contrib/git-jump, where an
>>> unmerged file in a run of "git jump merge" is reported as simply "binary
>>> file matches".
>>
>> Wow, what a beautiful contribution!
>>
>> I wonder how difficult it would be to make this work with gitattributes,
>> i.e. when .gitattributes' `eol` setting disagrees with core.eol.
>>
>> I imagine that we could use convert.c to do all the hard work, e.g. by
>> adding a function
>>
>> 	const char *eol_for_path(const char *path, const char *contents)
>> 	{
>> 		enum eol eol;
>> 		struct conv_attrs ca;
>> 		struct text_stat stats;
>>
>> 		convert_attrs(&ca, path);
>> 		eol = output_eol(ca.crlf_action);
>> 		if (eol != EOL_CRLF)
>> 			eol = EOL_LF;
>> 		else if (!*contents || (crlf_action != CRLF_AUTO &&
>> 				crlf_action != CRLF_GUESS)
>> 			eol = EOL_CRLF;
>> 		else {
>> 			ca.crlf_action = input_crlf_action(ca.crlf_action,
>> 					ca.eol_attr);
>> 			if (crlf_action == CRLF_GUESS && stats.cr > stats.crlf)
>> 				eol = core_eol;
>> 			else if (stats.crlf)
>> 				eol = EOL_CRLF;
>> 			else
>> 				eol = EOL_LF;
>> 		}
>>
>> 		return eol == EOL_CRLF ? "\r\n" : "\n";
>> 	}
> 
> Hi Johannes,
> 
> I have implemented this according to your algorithm. Now, I have to set
> core.autocrlf to true for making the new test pass. Setting core.eol no
> longer has an effect on the merge markers. Is this expected? (I haven't
> set any attributes)

PS: the function looks like this now:

enum eol eol_for_path(const char *path, const char *src, size_t len)
{
        struct conv_attrs ca;
        struct text_stat stats;

        convert_attrs(&ca, path);
        if (output_eol(ca.crlf_action) != EOL_CRLF)
                return EOL_LF;
        if (!len || ca.crlf_action != CRLF_AUTO &&
	            ca.crlf_action != CRLF_GUESS)
                return EOL_CRLF;
        ca.crlf_action = input_crlf_action(ca.crlf_action, ca.eol_attr);
        gather_stats(src, len, &stats);
        if (ca.crlf_action == CRLF_GUESS && stats.cr > stats.crlf)
                return core_eol;
        else if (stats.crlf)
                return EOL_CRLF;
        else
                return EOL_LF;
}
