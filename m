From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v4 4/4] format-patch: introduce format.base configuration
Date: Wed, 13 Apr 2016 23:55:58 +0800
Message-ID: <20160413155558.GA2680@yexl-desktop>
References: <1460342873-28900-1-git-send-email-xiaolong.ye@intel.com>
 <1460342873-28900-5-git-send-email-xiaolong.ye@intel.com>
 <xmqq37qqr4ms.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fengguang.wu@intel.com, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 17:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqNAB-0002jK-94
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 17:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753419AbcDMP4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 11:56:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:44340 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbcDMP4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 11:56:53 -0400
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP; 13 Apr 2016 08:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,480,1455004800"; 
   d="scan'208";a="84468679"
Received: from yexl-desktop.sh.intel.com (HELO localhost) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2016 08:56:51 -0700
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com
Content-Disposition: inline
In-Reply-To: <xmqq37qqr4ms.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291455>

On Tue, Apr 12, 2016 at 12:47:23PM -0700, Junio C Hamano wrote:
>Xiaolong Ye <xiaolong.ye@intel.com> writes:
>
>> +static int config_base_commit;
>
>This variable is used as a simple boolean whose name is overly broad
>(if it were named "config_base_auto" this complaint would not
>apply).  If you envision possible future enhancements for this
>configuration variable, "int config_base_commit" might make sense
>but I don't think of anything offhand that would be happy with
>"int".
>
>> @@ -786,6 +787,12 @@ static int git_format_config(const char *var, const char *value, void *cb)
>>  	}
>>  	if (!strcmp(var, "format.outputdirectory"))
>>  		return git_config_string(&config_output_directory, var, value);
>> +	if (!strcmp(var, "format.base")){
>
>Style. s/)){/)) {/
>
>> +		if (value && !strcasecmp(value, "auto")) {
>
>Does it make sense to allow "Auto" here?  Given that the command
>line parsing uses strcmp() to require "auto", I do not think so.
>
>> +			config_base_commit = 1;
>> +			return 0;
>> +		}
>
>When a value other than "auto" is given, is it sane to ignore them
>without even warning?
>
>I am wondering if this wants to be a format.useAutoBase boolean
>variable.
>

Thanks for the reminder, seems boolean variable is more suitable for
this case, I'll adopt to it in next iteration.
>> @@ -1215,7 +1222,12 @@ static void prepare_bases(struct base_tree_info *bases,
>>  	DIFF_OPT_SET(&diffopt, RECURSIVE);
>>  	diff_setup_done(&diffopt);
>>  
>> -	if (!strcmp(base_commit, "auto")) {
>> +	if (base_commit && strcmp(base_commit, "auto")) {
>> +		base = lookup_commit_reference_by_name(base_commit);
>> +		if (!base)
>> +			die(_("Unknown commit %s"), base_commit);
>> +		oidcpy(&bases->base_commit, &base->object.oid);
>> +	} else if ((base_commit && !strcmp(base_commit, "auto")) || config_base_commit) {
>
>It may be a poor design to teach prepare_bases() about "auto" thing.
>Doesn't it belong to the caller?  The caller used to say "If a base

Good point, as I understand your comments, we need to extract the "auto"
thing from prepare_bases() and call it early, then we could have a
concrete base before calling prepare_bases().

Thanks,
Xiaolong.
>is given, then call that function, by the way, the base must be a
>concrete one", and with the new "auto" feature, the caller loosens
>the last part of the statement and says "If a base is given, call
>that function, but if it is specified as "auto", I'd have to compute
>it for the user before doing so".
