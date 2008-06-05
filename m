From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] builtin-fast-export: Add importing and exporting of revision marks
Date: Thu, 5 Jun 2008 12:46:44 +0200
Message-ID: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl>
References: <1212612947-34720-1-git-send-email-pdebie@ai.rug.nl> <alpine.DEB.1.00.0806050052390.21190@racer>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 05 12:47:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4D0Q-0003rP-OR
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 12:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbYFEKqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 06:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755107AbYFEKqr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 06:46:47 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:27771 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754813AbYFEKqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 06:46:47 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6312.orange.nl (SMTP Server) with ESMTP id 869CE1C000A1;
	Thu,  5 Jun 2008 12:46:45 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6312.orange.nl (SMTP Server) with ESMTP id 0DB0E1C0008C;
	Thu,  5 Jun 2008 12:46:44 +0200 (CEST)
X-ME-UUID: 20080605104645561.0DB0E1C0008C@mwinf6312.orange.nl
In-Reply-To: <alpine.DEB.1.00.0806050052390.21190@racer>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83898>


On 5 jun 2008, at 02:00, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 4 Jun 2008, Pieter de Bie wrote:
>
>> +{
>> +	unsigned int i;
>> +	uintmax_t mark;
>> +	struct object_decoration *deco = idnums.hash;
>> +	FILE *f;
>> +
>> +	f = fopen(file, "w");
>> +	if (!f)
>> +		error("Unable to open marks file %s for writing", file);
>> +
>> +	for (i = 0; i < idnums.size; ++i) {
>> +		deco++;
>> +		if (deco && deco->base && deco->base->type == 1) {
>> +			mark = (uint32_t *) deco-> decoration - (uint32_t *)NULL;
>
> Why do you use uint32_t here, when you use uintmax_t to declare  
> "mark"?
>
> Also, there is an extra space after the closing paren.
>
> Is "- (uint32_t *)NULL" needed?

I changed the uintmax_t to to a uint32_t. If I remove the "- (uint32_t  
*)NULL",
it won't return the same marks. The same is done in get_object_mark().

>> +static void import_marks(char * input_file)
>> +{
>> +	char line[512];
>> +	FILE *f = fopen(input_file, "r");
>> +	if (!f)
>> +		die("cannot read %s: %s", input_file, strerror(errno));
>> +
>> +	while (fgets(line, sizeof(line), f)) {
>> +		uintmax_t mark;
>> +		char *end;
>> +		unsigned char sha1[20];
>> +		struct object *object;
>> +
>> +		end = strchr(line, '\n');
>> +		if (line[0] != ':' || !end)
>> +			die("corrupt mark line: %s", line);
>> +		*end = 0;
>> +		mark = strtoumax(line + 1, &end, 10);
>> +		if (!mark || end == line + 1
>> +			|| *end != ' ' || get_sha1(end + 1, sha1))
>> +			die("corrupt mark line: %s", line);
>
> You do a bit too much with "end" for my liking.  Better use two  
> variables,
> and spare the reader a (brief) "Huh?" moment.

Right. I copied this code from fast-export.c. I changed it to two  
variables now.

>> +		add_decoration(&idnums, object, ((uint32_t *)NULL) + mark);
>
> Better write (void *)mark.

That won't return the same result, as pointer addition goes with 4  
bytes. The
same thing is done in mark_object().

I will send an updated patch.

- Pieter
