From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Thu, 5 Jun 2008 01:00:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806050052390.21190@racer>
References: <1212612947-34720-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jun 05 02:03:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K42wW-0001Jm-E2
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 02:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760099AbYFEACI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 20:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759994AbYFEACI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 20:02:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:46636 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759972AbYFEACG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 20:02:06 -0400
Received: (qmail invoked by alias); 05 Jun 2008 00:02:03 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 05 Jun 2008 02:02:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/uyEsyVknufMqapnyFnLZ/Bk9G593WahyeGzqUtZ
	JBD6JhVFgRbHtB
X-X-Sender: gene099@racer
In-Reply-To: <1212612947-34720-1-git-send-email-pdebie@ai.rug.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83839>

Hi,

On Wed, 4 Jun 2008, Pieter de Bie wrote:

> +static void export_marks(char * file)

Extra space after star.

> +{
> +	unsigned int i;
> +	uintmax_t mark;
> +	struct object_decoration *deco = idnums.hash;
> +	FILE *f;
> +
> +	f = fopen(file, "w");
> +	if (!f)
> +		error("Unable to open marks file %s for writing", file);
> +
> +	for (i = 0; i < idnums.size; ++i) {
> +		deco++;
> +		if (deco && deco->base && deco->base->type == 1) {
> +			mark = (uint32_t *) deco-> decoration - (uint32_t *)NULL;

Why do you use uint32_t here, when you use uintmax_t to declare "mark"?

Also, there is an extra space after the closing paren.

Is "- (uint32_t *)NULL" needed?

> +			fprintf(f, ":%" PRIuMAX " %s\n", mark, sha1_to_hex(deco->base->sha1));

Too long line.

If you already only use uint32_t, I think you do not need the (ugly) 
PRIuMAX.

> +static void import_marks(char * input_file)
> +{
> +	char line[512];
> +	FILE *f = fopen(input_file, "r");
> +	if (!f)
> +		die("cannot read %s: %s", input_file, strerror(errno));
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		uintmax_t mark;
> +		char *end;
> +		unsigned char sha1[20];
> +		struct object *object;
> +
> +		end = strchr(line, '\n');
> +		if (line[0] != ':' || !end)
> +			die("corrupt mark line: %s", line);
> +		*end = 0;
> +		mark = strtoumax(line + 1, &end, 10);
> +		if (!mark || end == line + 1
> +			|| *end != ' ' || get_sha1(end + 1, sha1))
> +			die("corrupt mark line: %s", line);

You do a bit too much with "end" for my liking.  Better use two variables, 
and spare the reader a (brief) "Huh?" moment.

> +		object = parse_object(sha1);
> +		if (!object)
> +			die ("Could not read blob %s", sha1_to_hex(sha1));
> +
> +		if (object->flags & SHOWN)
> +			error("Object %s was already has a mark", sha1);

s/was //

> +		add_decoration(&idnums, object, ((uint32_t *)NULL) + mark);

Better write (void *)mark.

> +	char *export_filename, *import_filename;
>  	struct option options[] = {
>  		OPT_INTEGER(0, "progress", &progress,
>  			    "show progress after <n> objects"),
>  		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, "mode",
>  			     "select handling of signed tags",
>  			     parse_opt_signed_tag_mode),
> +		OPT_STRING(0, "export-marks", &export_filename, "FILE", "Dump marks to this file"),
> +		OPT_STRING(0, "import-marks", &import_filename, "FILE", "Import marks from this file"),

Two long lines.

>  		OPT_END()
>  	};
>  
>  	/* we handle encodings */
>  	git_config(git_default_config, NULL);
>  
> +
>  	init_revisions(&revs, prefix);

Unnecessary change.

Other than that: ACK.

Thanks,
Dscho
