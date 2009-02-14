From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 22:31:09 +0200
Message-ID: <94a0d4530902141231t143067e5n872558a4e515be4a@mail.gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 21:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRC4-0006yY-Gq
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 21:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbZBNUbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 15:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZBNUbN
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 15:31:13 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:38379 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbZBNUbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 15:31:13 -0500
Received: by fxm13 with SMTP id 13so4579487fxm.13
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 12:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vt5J2IkBTATqpyf/UjYWpsDoV4hr0EV5HjlEAjuMxTA=;
        b=x+M6hJYBwFpOvm/kN3dnpahay8zmKppq0M68x8Y4xw0NbDsYmwF4JpX2uzXzXf8718
         riIY5F0jVFhIQqHJYgDCXKl6pjbCB51VlamXh5zqwJipZ6gqxuSJ8WU/oMEkQyKYyHJn
         88rZPgRU5gebdPmzhY2ZM42eBeIc9i/+bg2pQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RXg3oOo5IbOW5I2iA6jTD0gCwV50D2C+n5PNA/vn0yHdhcnaWUgKy0ZeOhFKJLLWPr
         YJd5ljzB+BMPvTC5LYXrUBBgDsdxGomG+q8FlzjnNHzh0Z7ciBzCNNUO4yhI9OEIxS8h
         sDVNHQWhJZ99GFYueDqbxfvFHbfBkh/klk7vk=
Received: by 10.86.92.4 with SMTP id p4mr513420fgb.36.1234643469117; Sat, 14 
	Feb 2009 12:31:09 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109922>

On Sat, Feb 14, 2009 at 9:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 14 Feb 2009, Felipe Contreras wrote:
>
>> @@ -231,7 +264,7 @@ static int get_diff_color_found;
>>  static int git_get_colorbool_config(const char *var, const char *value,
>>               void *cb)
>>  {
>> -     if (!strcmp(var, get_color_slot)) {
>> +     if (!strcmp(var, get_colorbool_slot)) {
>>               get_colorbool_found =
>>                       git_config_colorbool(var, value, stdout_is_tty);
>>       }
>
> Name changes like this make it harder to read the patch; can you separate
> that change out into its own patch?

In that case I couldn't use OPT_STRING to store that value; I would
have to change --get-color* to use OPT_BOOLEAN or OPT_SET_INT and
store check the argc (since OPT_STRING isn't doing that anymore) and
save argv[1] to get_color_slot,

>> +     if (use_global_config) {
>> +             char *home = getenv("HOME");
>> +             if (home) {
>> +                     char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
>> +                     config_exclusive_filename = user_config;
>
> In a subsequent patch, you might add a check only one of --global,
> --system or --file was given.

Yeap.

>> +     else if (given_config_file) {
>> +             if (!is_absolute_path(given_config_file) && file)
>> +                     file = prefix_filename(file, strlen(file),
>> +                                            given_config_file);
>> +             else
>> +                     file = given_config_file;
>> +             config_exclusive_filename = file;
>
> It took me a considerable amount of time to figure out that "file" is
> actually the "prefix"!  That cleanup would be nice to have before the
> parseopt patch, methinks, especially since the code is reindented, and
> thus hard to follow in the diff.

True.

I tried to minimize changes, so that code is exactly the same as
before (except vi didn't preserve the indent).

>> +     if (actions & ACTION_LIST) {
>> +             if (git_config(show_all_config, NULL) < 0 &&
>> +                 file && errno)
>
> Should this not be config_exclusive_filename?

Looks like that.

>> +                     die("unable to read config file %s: %s", file,
>> +                         strerror(errno));
>
> Do we really only want to die() in case we know the file name?  AFAICT at
> this point we have no idea in which of the possibly three files the error
> occurred.  And there need not be any errno set, for example when there was
> a parse error.

Yes, there should be an error even if 'file' is not set. But if the
file is set what's wrong with that die command?

>> +     else if (actions & ACTION_EDIT) {
>> +             const char *config_filename;
>> +             if (config_exclusive_filename)
>> +                     config_filename = config_exclusive_filename;
>> +             else
>> +                     config_filename = git_path("config");
>
> Why not reuse config_exclusive_filename here?

You mean:
if (!config_exclusive_filename)
  config_exclusive_filename = git_path("config");

>> +     else if (actions & ACTION_ADD) {
>> +             check_argc(argc, 2, 2);
>
> BTW what about check_argc() in the previous two cases?

You mean fail if -e or -l have extra arguments?

>> +             return git_config_set_multivar(argv[0], value, "^$", 0);
>
> Now that I see this, there is another idea for a possible cleanup after
> the parseoptification: cmd_config() should not return -1, as that will be
> turned into the exit status.  So maybe prefix the return value with "!!"?
>
> Or maybe even better: set a variable "ret" and at the end of cmd_config(),
> "return !!ret;"?

Huh? So git commands don't return negative error values?

-- 
Felipe Contreras
