From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: git diff does not precompose unicode file paths (OS X)
Date: Fri, 4 Mar 2016 18:49:42 +0000
Message-ID: <56D9D8C6.2060104@ramsayjones.plus.com>
References: <0008C25D-C3F0-4A1F-8B50-4EF1E84CA04F@fournova.com>
 <56D97C8C.1060205@web.de> <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexander Rinass <alex@fournova.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershause?= =?UTF-8?Q?n?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:50:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abunY-0005eH-Or
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 19:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759626AbcCDSts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2016 13:49:48 -0500
Received: from avasout03.plus.net ([84.93.230.244]:48171 "EHLO
	avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759566AbcCDStq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 13:49:46 -0500
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout03 with smtp
	id Rupj1s0041BQLD401upkc9; Fri, 04 Mar 2016 18:49:45 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=X8+vUzne c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=O8LZU4p855Uq0NwHuYsA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <D9E0FEEC-1987-4045-AD0F-4C7C76DC067B@fournova.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288270>



On 04/03/16 14:37, Alexander Rinass wrote:
>=20
>> On 04 Mar 2016, at 13:16, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>>
>> On 03/04/2016 10:07 AM, Alexander Rinass wrote:
[snip]

>=20
> Sticking a precompose_argv(argc, argv) into diff.c=E2=80=99s cmd_diff=
 function fixes the issue.
>=20
> But I had to disable the check (precomposed_unicode !=3D 1) in precom=
pose_argv to make it work. That=E2=80=99s probably because precompose_a=
rgv is usually called from parse_options and is missing some other call=
 before it?
>=20

Yes, you need to place it after the configuration is read, but before
calls to diff_no_index() or setup_revisions(). Directly after the call
to git_config() should be fine. [But this begs the question about other
commands, including plumbing, which don't call parse_options().]

Maybe this will work for you (I can't test it, since I don't have any
access to a Mac):

diff --git a/builtin/diff.c b/builtin/diff.c
index 343c6b8..b7a9405 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -320,6 +320,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		gitmodules_config();
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
+	precompose_argv(argc, argv);
=20
 	init_revisions(&rev, prefix);
=20


ATB,
Ramsay Jones
