From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv3 0/2] Fix relative path issues in recursive submodules.
Date: Wed, 13 Apr 2016 20:21:42 +0100
Message-ID: <570E9C46.6080905@ramsayjones.plus.com>
References: <1459469849-9643-1-git-send-email-sbeller@google.com>
 <56FE8898.20906@ramsayjones.plus.com>
 <CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:22:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqQMP-0005eQ-PX
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 21:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbcDMTVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 15:21:52 -0400
Received: from avasout07.plus.net ([84.93.230.235]:39171 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbcDMTVv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 15:21:51 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id hvMk1s00A2D2Veb01vMllM; Wed, 13 Apr 2016 20:21:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=wE0t0PBJmfkm-szk2hMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAGZ79kYE3E7stNc3Xbzr-qvncLGt4qRPMbv897k5h0B50-Rogg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291480>



On 12/04/16 16:58, Stefan Beller wrote:
> On Fri, Apr 1, 2016 at 7:41 AM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
[snip[

>>> -     }
>>> +     sm_gitdir_rel = strbuf_detach(&sb, NULL);
>>
>> ... this is good, but ...
>>
>>> +     sm_gitdir = absolute_path(sm_gitdir_rel);
>>>
>>>       if (!is_absolute_path(path)) {
>>> -             /*
>>> -              * TODO: add prefix here once we allow calling from non root
>>> -              * directory?
>>> -              */
>>> -             strbuf_addf(&sb, "%s/%s",
>>> -                         get_git_work_tree(),
>>> -                         path);
>>> +             strbuf_addf(&sb, "%s/%s", get_git_work_tree(), path);
>>>               path = strbuf_detach(&sb, 0);
>>
>> ... can you please fix this up.
>>
>> Thanks!
>>
>> ATB,
>> Ramsay Jones
> 
> Looking at the current code of origin/sb/submodule-helper-clone-regression-fix
> we do not have this issue there, but I'll keep it in mind for a resend.

Hmm, actually, the above change wasn't the original culprit (as I thought), but
a different instance of the same fault. :-D

I've lost track of which version is now in 'pu' (currently @ 45a4edc "Merge branch
'sb/submodule-init' into pu"), but sparse is still warning:

      SP submodule.c
  submodule.c:256:43: warning: Using plain integer as NULL pointer

So, the fix looks like:

  diff --git a/submodule.c b/submodule.c
  index 5d1238a..4cc1c27 100644
  --- a/submodule.c
  +++ b/submodule.c
  @@ -253,7 +253,7 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
                  return NULL;
          case SM_UPDATE_COMMAND:
                  strbuf_addf(&sb, "!%s", s->command);
  -               return strbuf_detach(&sb, 0);
  +               return strbuf_detach(&sb, NULL);
          }
          return NULL;
   }

Also, I note that t7406-submodule-update.sh test #4 is failing.
(looks like absolute vs relative paths)

ATB,
Ramsay Jones
