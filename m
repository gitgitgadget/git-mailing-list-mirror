From: Jharrod LaFon <jlafon@eyesopen.com>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 08:12:33 -0700
Message-ID: <AFCBD71A-21CB-45CC-8386-C65173B6D173@eyesopen.com>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de> <20130816130957.GB20138@sigill.intra.peff.net>
 <20130816131406.GC20138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 16 17:12:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VALhf-0005MG-Q5
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 17:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab3HPPMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 11:12:34 -0400
Received: from exhub018-2.exch018.msoutlookonline.net ([64.78.17.17]:36281
	"EHLO EXHUB018-2.exch018.msoutlookonline.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752751Ab3HPPMd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 11:12:33 -0400
Received: from EXVMBX018-11.exch018.msoutlookonline.net ([64.78.17.52]) by
 EXHUB018-2.exch018.msoutlookonline.net ([64.78.17.17]) with mapi; Fri, 16 Aug
 2013 08:12:33 -0700
Thread-Topic: [PATCH] Git segmentation faults if submodule path is empty.
Thread-Index: Ac6akwg6nTJ79osPTU+11QIob57bDQ==
In-Reply-To: <20130816131406.GC20138@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232433>

OK,  I'll incorporate Jeff's changes, add a test and resubmit the patch.

Thanks,

--
Jharrod LaFon
OpenEye Scientific Software

On Aug 16, 2013, at 7:14 AM, Jeff King <peff@peff.net> wrote:

> On Fri, Aug 16, 2013 at 09:09:58AM -0400, Jeff King wrote:
> 
>>>> -	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
>>>> +	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name || !value)
>>>> 		return 0;
>> 
>> I think this is also the wrong place to make the check, anyway. It is
>> saying that all values of submodule.X.Y must be non-NULL. But that is
>> not true. The submodule.X.fetchRecurseSubmodules option can be a
>> boolean, and:
>> 
>>  [submodule "foo"]
>>    fetchRecurseSubmodules
>> 
>> is perfectly valid (and is broken by this patch).
> 
> IOW, I think this is the right fix:
> 
> diff --git a/submodule.c b/submodule.c
> index 3f0a3f9..c0f93c2 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -134,6 +134,9 @@ int parse_submodule_config_option(const char *var, const char *value)
> 		return 0;
> 
> 	if (!strcmp(key, "path")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +
> 		config = unsorted_string_list_lookup(&config_name_for_path, value);
> 		if (config)
> 			free(config->util);
> @@ -151,6 +154,9 @@ int parse_submodule_config_option(const char *var, const char *value)
> 	} else if (!strcmp(key, "ignore")) {
> 		char *name_cstr;
> 
> +		if (!value)
> +			return config_error_nonbool(var);
> +
> 		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
> 		    strcmp(value, "all") && strcmp(value, "none")) {
> 			warning("Invalid parameter \"%s\" for config option \"submodule.%s.ignore\"", value, var);
> 
> And new options, as they are added, must decide whether they are boolean
> or not (and check !value as appropriate).
> 
> -Peff
