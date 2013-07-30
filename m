From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 5/5] rm: delete .gitmodules entry of submodules removed
 from the work tree
Date: Wed, 31 Jul 2013 01:06:34 +0200
Message-ID: <51F846FA.8030808@web.de>
References: <51F8187F.7040603@web.de> <51F81957.1000709@web.de> <20130730201511.GC19369@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 01:06:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4J09-0003uO-NE
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 01:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab3G3XGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 19:06:41 -0400
Received: from mout.web.de ([212.227.15.3]:55049 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab3G3XGl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 19:06:41 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M24rL-1UCD2a0FR5-00u5Ry for <git@vger.kernel.org>;
 Wed, 31 Jul 2013 01:06:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130730201511.GC19369@paksenarrion.iveqy.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:yD5AGj0vSl48emnC+cUYhD/M5mDiKuREHGcYM7FqCF4TR70z9ZF
 bebpEDnTpztc2HK3skEu87j2PC1GR0plPG5j1Tx1BNFs2elZk3aEAtiFOQ06yAi/6KC6ii8
 Jersz7Y5lD4kyXqlcP4Y1GRdrAXsG/fKe/nIQOh/B60nLOLnOZ+SZzlyu4PDyE+2zXXTroK
 2GktUAOqHmr0F2We1s/Aw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231397>

Am 30.07.2013 22:15, schrieb Fredrik Gustafsson:
> On Tue, Jul 30, 2013 at 09:51:51PM +0200, Jens Lehmann wrote:
>> +/*
>> + * Try to remove the "submodule.<name>" section from .gitmodules where the given
>> + * path is configured. Return 0 only if a .gitmodules file was found, a section
>> + * with the correct path=<path> setting was found and we could remove it.
>> + */
>> +int remove_path_from_gitmodules(const char *path)
>> +{
>> +	struct strbuf sect = STRBUF_INIT;
>> +	struct string_list_item *path_option;
>> +
>> +	if (!file_exists(".gitmodules")) /* Do nothing without .gitmodules */
>> +		return -1;
>> +
>> +	if (gitmodules_is_unmerged)
>> +		die(_("Cannot change unmerged .gitmodules, resolve merge conflicts first"));
>> +
>> +	path_option = unsorted_string_list_lookup(&config_name_for_path, path);
>> +	if (!path_option) {
>> +		warning(_("Could not find section in .gitmodules where path=%s"), path);
>> +		return -1;
>> +	}
>> +	strbuf_addstr(&sect, "submodule.");
>> +	strbuf_addstr(&sect, path_option->util);
>> +	if (git_config_rename_section_in_file(".gitmodules", sect.buf, NULL) < 0) {
>> +		/* Maybe the user already did that, don't error out here */
>> +		warning(_("Could not remove .gitmodules entry for %s"), path);
>> +		return -1;
>> +	}
>> +	strbuf_release(&sect);
>> +	return 0;
>> +}
> 
> This question applies for this function and a few more functions in this
> patch that has the same characteristics.
> 
> If we're in a state when we need to return non-zero, we don't do any
> cleaning (that is strbuf_release()). Since this file is in the part
> called libgit AFAIK, shouldn't we always clean after us?

Right you are, thanks for bringing that up. The last return needs a
strbuf_release(), will fix that in v4.

> Would it make sense to have different return values for different
> errors?

I don't think so. The caller only wants to know if the modification
of the .gitmodules file happened or not, so he can decide if that
needs to be staged.
